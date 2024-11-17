#include <iostream>
#include <sstream>
#include <string>
#include <unistd.h>
#include <sys/stat.h>
#include <iomanip>

#include "utils.h"
#include "FunctionAnalysis.h"

clang::LangOptions lopt;

std::string FunctionAnalysisVisitor::SourceRangeToString(SourceRange range) {
    SourceManager& sm = astContext->getSourceManager();

    //Use LLVM's lexer to get source text.
    llvm::StringRef ref = Lexer::getSourceText(CharSourceRange::getCharRange(range), sm, astContext->getLangOpts());
    return ref.str();
}

void FunctionAnalysisVisitor::ProcessEndOfBasicBlock(BasicBlockInfo* info, CompoundStmtIter* iter) {
    if (iter->basicBlockHead != iter->stmt->body_end()) {
        // create basic block between head and tail
        BasicBlockInfo basicBlock;
        basicBlock.blockType = BLOCK_TYPE_BASIC;

        CompoundStmt::const_body_iterator it = iter->basicBlockHead;
        CompoundStmt::const_body_iterator it_end = iter->basicBlockTail;

        SourceRange basicBlockRange;
        basicBlockRange.setBegin((*it)->getSourceRange().getBegin());
        basicBlockRange.setEnd((*it_end)->getSourceRange().getEnd());        
        basicBlock.range = basicBlockRange;

        do {
            // TODO: get function calls
            basicBlock.statements.push_back(CreateStatementInfo(*it));
            if (it != it_end)
                it++;
            else
                break;
        } while (true);

        info->blocks.push_back(basicBlock);

        // clear iter
        iter->basicBlockHead = iter->stmt->body_end();
        iter->basicBlockTail = iter->stmt->body_end();
    }
}

void FunctionAnalysisVisitor::ProcessCompoundStatement(BasicBlockInfo* parentInfo, BasicBlockInfo& basicBlock, const CompoundStmt* compoundStmt) {
    CompoundStmtIter iter;
    iter.stmt = compoundStmt;
    iter.basicBlockHead = compoundStmt->body_end();
    iter.basicBlockTail = compoundStmt->body_end();

    CompoundStmt::const_body_iterator it;
    for (it =compoundStmt->body_begin(); it != compoundStmt->body_end(); it++){
        ProcessStatement(&basicBlock, it, &iter);
    }

    ProcessEndOfBasicBlock(&basicBlock, &iter);
}

bool FunctionAnalysisVisitor::VisitStmt(Stmt* st) {
    if (!traversingSingleStatement)
        return true;    

    StatementTreeNode node;
    if (traversingSingleStatement->currentIndex == 0)
        node.parent = -1;
    else {
        node.parent = -2;
        const auto& parents = astContext->getParents(*st);
        if (!parents.empty()) {
            const Stmt* parentStmt = parents[0].get<Stmt>();
            if (parentStmt) {
                for (int i = 0; i < traversingSingleStatement->tree.size(); i++) {
                    if (traversingSingleStatement->tree[i].stmt == parentStmt) {
                        node.parent = i;
                        break;
                    }
                }
            }
            // TODO: hack for DeclStmt RHS
            else if (traversingSingleStatement->currentIndex == 1) {
                node.parent = 0;
            }
        }

    }
    node.stmt = st;
    node.isFloatType = false;
    if (const DeclRefExpr* decl = dyn_cast<DeclRefExpr>(st)) {
        const ValueDecl* valueDecl = decl->getDecl();

        if (const FunctionDecl* funcDecl = dyn_cast<FunctionDecl>(valueDecl)) {
            node.type = SUBEX_TYPE_FUNC;
            QualType returnType = funcDecl->getReturnType();
            FloatingPointTypeInfo info = DissectFloatingPointType(returnType, true);
            node.isFloatType = info.isFloatingPoint;
        }
        else {
            node.type = SUBEX_TYPE_VAR;
            node.isFloatType = IsFloatingPointDecl(valueDecl);
        }
    }
    else if (const CallExpr* call = dyn_cast<CallExpr>(st)) {
        node.type = SUBEX_TYPE_CALLEXPR;
        QualType returnType = call->getCallReturnType(*astContext);
        FloatingPointTypeInfo info = DissectFloatingPointType(returnType, true);
        node.isFloatType = info.isFloatingPoint;
    }
    else if (const BinaryOperator* bo = dyn_cast<BinaryOperator>(st)) {
        node.type = SUBEX_TYPE_OP;
    }
    else if (const UnaryOperator* uo = dyn_cast<UnaryOperator>(st)) {
        node.type = SUBEX_TYPE_OP;
    }    
    else {
        node.type = SUBEX_TYPE_OTHER;
    }

    string prefix = "--> Statement " + std::to_string(traversingSingleStatement->currentIndex) + ", parent " + std::to_string(node.parent) + ": ";
    PrintStatement(prefix, st, astContext);

    traversingSingleStatement->tree.push_back(node);

    if (st == anchorPointForRHS)
        traversingSingleStatement->rhsStart = traversingSingleStatement->currentIndex;

    anchorPointForRHS = FindLHSRHS(st, anchorPointForRHS, NULL, astContext);

    // look for the actual L-value it writes to
    if (anchorPointForRHS) {
        if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
            const ValueDecl* valueDecl = declRefExpr->getDecl();
            if (IsFloatingPointDecl(valueDecl)) {
                PrintStatement("\t\tadded to write: ", st, astContext);                
                traversingSingleStatement->writes.push_back(declRefExpr);
            }
        }
    }
    // find writes here
    else {
        if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
            const ValueDecl* valueDecl = declRefExpr->getDecl();
            if (IsFloatingPointDecl(valueDecl)) {
                PrintStatement("\t\t\tadded to read: ", st, astContext);
                traversingSingleStatement->reads.push_back(declRefExpr);
            }
        }
    }

    if (anchorPointForRHS == st) {
        anchorPointForRHS = NULL;
    }

    // find declarations
    if (const DeclStmt* declStmt = dyn_cast<DeclStmt>(st)) {
        if (declStmt->isSingleDecl()) {
            const Decl* decl = declStmt->getSingleDecl();
            if (isa<VarDecl>(decl) && IsFloatingPointDecl(decl)) {
                PRINT_DEBUG_MESSAGE("\t\t\tadded to definitions");
                const VarDecl* varDecl = dyn_cast<VarDecl>(decl);
                traversingSingleStatement->decls.push_back(varDecl);

                if (varDecl->hasDefinition() == VarDecl::Definition) {            
                    if (varDecl->getAnyInitializer())  {
                        PrintStatement("\t--> initializer: ", varDecl->getAnyInitializer(), astContext);
                        traversingSingleStatement->definitions.push_back(varDecl);
                    }      
                }
            }
        }
        else {
            DeclStmt::const_decl_iterator it;
            for (it = declStmt->decl_begin(); it != declStmt->decl_end(); it++) {
                const Decl* decl = *it;
                if (isa<VarDecl>(decl) && IsFloatingPointDecl(decl)) {
                    PRINT_DEBUG_MESSAGE("\t\t\tadded to definitions");
                    const VarDecl* varDecl = dyn_cast<VarDecl>(decl);
                    traversingSingleStatement->decls.push_back(varDecl);

                    if (varDecl->hasDefinition() == VarDecl::Definition) {            
                        if (varDecl->getAnyInitializer()) {
                            PrintStatement("\t--> initializer: ", varDecl->getAnyInitializer(), astContext);
                            traversingSingleStatement->definitions.push_back(varDecl);
                        }
                    }                    
                }
            }
        }
    }

    // find calls
    if (const CallExpr* call = dyn_cast<CallExpr>(st)) {
        bool isAssignmentCall = false;
        bool isFpCall = false;
        if (isa<CXXOperatorCallExpr>(st)) {
            const CXXOperatorCallExpr* opOverload = dyn_cast<CXXOperatorCallExpr>(st);
            if (opOverload->isAssignmentOp()) {
                isAssignmentCall = true;
            }
        }

        for (unsigned int i = 0; i < call->getNumArgs(); i++) {
            PrintStatement("\t\targ: ", call->getArg(i), astContext);
            PRINT_DEBUG_MESSAGE("\t\targ type: " << call->getArg(i)->getType().getAsString());
            FloatingPointTypeInfo info = DissectFloatingPointType(call->getArg(i)->getType(), true);
            isFpCall |= info.isFloatingPoint;
            if (const ImplicitCastExpr* impCast = dyn_cast<ImplicitCastExpr>(call->getArg(i))) {
                if (impCast->getCastKind() == CK_ArrayToPointerDecay) {            
                    PRINT_DEBUG_MESSAGE("\t\t\tthis is an array passed as pointer");                    
                }
            }
        }
        
        // get return type
        isFpCall |= DissectFloatingPointType(call->getCallReturnType(*astContext), true).isFloatingPoint;

        if (!isAssignmentCall && isFpCall) {
            if (call->getDirectCallee()) {
                PRINT_DEBUG_MESSAGE("\t\t\tadded to calls:" << call->getDirectCallee()->getNameInfo().getAsString());
            }                
            else {
                PRINT_DEBUG_MESSAGE("\t\t\tadded to calls:");
            }
            traversingSingleStatement->calls.push_back(call);
        }
    }

    // find literals
    if (const FloatingLiteral* literal = dyn_cast<FloatingLiteral>(st)) {
        PRINT_DEBUG_MESSAGE("\t\t\tadded to consts");
        traversingSingleStatement->consts.push_back(literal);
    }

    traversingSingleStatement->currentIndex++;
    return true;
}

StatementInfo FunctionAnalysisVisitor::CreateStatementInfo(const Stmt* st) {
    StatementInfo info;
    info.stmt = st;
    info.range = st->getSourceRange();
    info.currentIndex = 0;
    info.rhsStart = 0;

    PrintStatement("Statement: ", st, astContext);

    // detect declarations, read/writes, etc. by traversing this single statement.
    // for example, aa = 1.0; can break down to
    //      * binary operation aa = 1.0
    //      * declaration reference expression aa
    //      * floating point literal 1.0
    traversingSingleStatement = &info;
    TraverseStmt((Stmt*)st);
    traversingSingleStatement = NULL;
    
    return info;
}

void FunctionAnalysisVisitor::ProcessStatement(BasicBlockInfo* info, CompoundStmt::const_body_iterator stmtIt, CompoundStmtIter* stmtIter) {
    const Stmt * st = *stmtIt;

    if (IsComplexStatement(st)) {
        ProcessEndOfBasicBlock(info, stmtIter);
    }

    if (isa<CompoundStmt>(st)) {
        PRINT_DEBUG_MESSAGE("\tis compound; most likely an individual {} block");

        BasicBlockInfo basicBlock;
        basicBlock.blockType = BLOCK_TYPE_BASIC;
        basicBlock.range = st->getSourceRange();

        const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(st);
        ProcessCompoundStatement(info, basicBlock, compoundStmt);
        info->blocks.push_back(basicBlock);
    }
    else if (isa<ForStmt>(st)) {
        PRINT_DEBUG_MESSAGE("\tfor statement");

        const ForStmt* forStmt = dyn_cast<ForStmt>(st);
        const Stmt* loopInit = forStmt->getInit();
        const Expr* loopCond = forStmt->getCond();
        const Expr* loopInc = forStmt->getInc();

        BasicBlockInfo topBB;
        topBB.blockType = BLOCK_TYPE_LOOP;
        topBB.range = forStmt->getSourceRange();

        // process head
        BasicBlockInfo headBlock;
        headBlock.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        SourceRange forHeadRange;
        forHeadRange.setBegin(loopInit->getSourceRange().getBegin());
        forHeadRange.setEnd(loopInc->getSourceRange().getEnd());
        headBlock.range = forHeadRange;

        headBlock.statements.push_back(CreateStatementInfo(loopInit));
        headBlock.statements.push_back(CreateStatementInfo(loopCond));
        headBlock.statements.push_back(CreateStatementInfo(loopInc));

        topBB.blocks.push_back(headBlock);

        // process body
        BasicBlockInfo basicBlock;
        basicBlock.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        basicBlock.range = forStmt->getBody()->getSourceRange();

        const Stmt* loopBody = forStmt->getBody();

        // compound for body;
        if (isa<CompoundStmt>(loopBody)) {
            const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(loopBody);
            ProcessCompoundStatement(info, basicBlock, compoundStmt);
        }
        // single for body;
        else {
            StatementInfo stmtInfo;
            stmtInfo.range = loopBody->getSourceRange();
            // TODO: get function calls
            basicBlock.statements.push_back(stmtInfo);
        }
        
        topBB.blocks.push_back(basicBlock);
        info->blocks.push_back(topBB);
    }
    else if (isa<DoStmt>(st)) {
        const DoStmt* doSt = dyn_cast<DoStmt>(st);
        //const Expr* cond = doSt->getCond();
        const Stmt* body = doSt->getBody();

        BasicBlockInfo topBB;
        topBB.blockType = BLOCK_TYPE_LOOP;
        topBB.range = doSt->getSourceRange();

        // body block
        BasicBlockInfo basicBlock;
        basicBlock.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        basicBlock.range = body->getSourceRange();

        // compound do body;
        if (isa<CompoundStmt>(body)) {
            const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(body);
            ProcessCompoundStatement(info, basicBlock, compoundStmt);
        }
        // single do body;
        else {
            StatementInfo stmtInfo;
            stmtInfo.range = body->getSourceRange();
            // TODO: get function calls
            basicBlock.statements.push_back(stmtInfo);
        }
        topBB.blocks.push_back(basicBlock);

        // condition block
        BasicBlockInfo condBB;
        condBB.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        condBB.range = doSt->getCond()->getSourceRange();
        condBB.statements.push_back(CreateStatementInfo(doSt->getCond()));
        topBB.blocks.push_back(condBB);

        info->blocks.push_back(topBB);
    }
    else if (isa<WhileStmt>(st)) {
        const WhileStmt* whileStmt = dyn_cast<WhileStmt>(st);
        //const Expr* cond = whileStmt->getCond();
        const Stmt* body = whileStmt->getBody();

        BasicBlockInfo topBB;
        topBB.blockType = BLOCK_TYPE_LOOP;
        topBB.range = whileStmt->getSourceRange();

        // condition block
        BasicBlockInfo condBB;
        condBB.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        condBB.range = whileStmt->getCond()->getSourceRange();
        condBB.statements.push_back(CreateStatementInfo(whileStmt->getCond()));

        topBB.blocks.push_back(condBB);

        // body block
        BasicBlockInfo basicBlock;
        basicBlock.blockType = BLOCK_TYPE_LOOP_COMPONENT;
        basicBlock.range = body->getSourceRange();

        // compound do body;
        if (isa<CompoundStmt>(body)) {
            const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(body);
            ProcessCompoundStatement(info, basicBlock, compoundStmt);
        }
        // single do body;
        else {
            StatementInfo stmtInfo;
            stmtInfo.range = body->getSourceRange();
            // TODO: get function calls
            basicBlock.statements.push_back(stmtInfo);
        }
        
        topBB.blocks.push_back(basicBlock);
        info->blocks.push_back(topBB);
    }
    else if (isa<IfStmt>(st)) {        
        const IfStmt* ifSt = dyn_cast<IfStmt>(st);
        const Stmt* thenBody = ifSt->getThen();
        const Stmt* elseBody = ifSt->getElse();

        // create a parent basic block for if/elif/else
        BasicBlockInfo topBB;
        topBB.blockType = BLOCK_TYPE_COND;
        topBB.range = ifSt->getSourceRange();

        PRINT_DEBUG_MESSAGE("\tif statement: " << thenBody << ", " << elseBody);

        // treat it as three basic blocks
        // if block
        BasicBlockInfo condBB;
        condBB.blockType = BLOCK_TYPE_COND_COMPONENT;
        condBB.range = ifSt->getCond()->getSourceRange();
        condBB.statements.push_back(CreateStatementInfo(ifSt->getCond()));

        topBB.blocks.push_back(condBB);

        // then block
        if (thenBody) {
            BasicBlockInfo thenBB;
            thenBB.blockType = BLOCK_TYPE_COND_COMPONENT;
            thenBB.range = thenBody->getSourceRange();

            // compound then        
            if (isa<CompoundStmt>(thenBody)) {
                const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(thenBody);
                ProcessCompoundStatement(info, thenBB, compoundStmt);
            }
            // single then
            else {
                thenBB.statements.push_back(CreateStatementInfo(thenBody));
            }

            topBB.blocks.push_back(thenBB);
        }

        // else block (if it exists)
        if (elseBody) {
            BasicBlockInfo elseBB;
            elseBB.blockType = BLOCK_TYPE_COND_COMPONENT;
            elseBB.range = elseBody->getSourceRange();

            // compound then        
            if (isa<CompoundStmt>(elseBody)) {
                const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(elseBody);
                ProcessCompoundStatement(info, elseBB, compoundStmt);
            }
            // single then
            else {
                elseBB.statements.push_back(CreateStatementInfo(elseBody));
            }

            topBB.blocks.push_back(elseBB);
        }
        info->blocks.push_back(topBB);
    }
    else if (isa<SwitchStmt>(st)) {
        PRINT_DEBUG_MESSAGE("\tswitch/case statement");
        const SwitchStmt* swStmt = dyn_cast<SwitchStmt>(st);
        // TODO: since switch condition is an integer expression, its priority is VERY low.
        BasicBlockInfo topBB;
        topBB.blockType = BLOCK_TYPE_COND;
        topBB.range = swStmt->getSourceRange();

        // iterate between switch cases
        const SwitchCase* casePos = swStmt->getSwitchCaseList();
        while (casePos) {
            const Stmt* subStmt = casePos->getSubStmt();
            BasicBlockInfo caseBB;
            caseBB.blockType = BLOCK_TYPE_COND_COMPONENT;
            caseBB.range = subStmt->getSourceRange();

            if (isa<CompoundStmt>(subStmt)) {
                const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(subStmt);
                ProcessCompoundStatement(info, caseBB, compoundStmt);                
            }
            else {
                caseBB.statements.push_back(CreateStatementInfo(subStmt));
            }

            topBB.blocks.push_back(caseBB);

            casePos = casePos->getNextSwitchCase();
        }
        info->blocks.push_back(topBB);
    }
    else {
        // regular statement
        StatementInfo stInfo;
        stInfo.range = st->getSourceRange();
        // TODO: function calls

        if (stmtIter->basicBlockHead == stmtIter->stmt->body_end()) {
            stmtIter->basicBlockHead = stmtIt;
        }
        stmtIter->basicBlockTail = stmtIt;
    }
}

bool FunctionAnalysisVisitor::VisitFunctionDecl(FunctionDecl* func) {
    auto loc1 = func->getLocation();
    FileID id = rewriter.getSourceMgr().getMainFileID();    
    string originalFilename = astContext->getSourceManager().getFilename(astContext->getSourceManager().getLocForStartOfFile(id)).str();
    // check against a list of excluded directories
    for (size_t i = 0; i < sizeof(sSystemIncludeDirectories) / sizeof(const char*); i++) {
        string fileName = astContext->getSourceManager().getFilename(loc1).str();
        if (fileName == "" || fileName.find(sSystemIncludeDirectories[i]) != std::string::npos)
            return true;
        if (fileName != originalFilename)
            return true;
    }

    if (!func->doesThisDeclarationHaveABody())
        return true;

    // check function signature (host/global/device) and determine the types to use for replacement
    bool isHostFunc = true;
    SourceRange declRange = clang::SourceRange(func->getSourceRange().getBegin(), func->getBody()->getSourceRange().getBegin());
    StringRef declStr = Lexer::getSourceText(clang::CharSourceRange::getTokenRange(declRange), astContext->getSourceManager(), astContext->getLangOpts());
    PRINT_DEBUG_MESSAGE("Function Decl: " << declStr.substr(0, declStr.size() - 2).str());
    if (declStr.find("__global__") != std::string::npos)
        isHostFunc = false;
    else if (declStr.find("__device__") != std::string::npos)
        isHostFunc = false;
    else {
        isHostFunc = true;
        if (!searchInHostFunctions)
            return true;
    }

    if (funcInfos.find(func->getNameInfo().getName().getAsString()) == funcInfos.end()) {
        FunctionInfo* info = new FunctionInfo();
        const CompoundStmt *fBody = dyn_cast<CompoundStmt>(func->getBody());
        info->name = func->getNameInfo().getName().getAsString();
        info->range = fBody->getSourceRange();
        info->blockType = BLOCK_TYPE_FUNC;
        funcInfos[info->name] = info;

        PRINT_DEBUG_MESSAGE("Function Name: " << info->name);
        
        CompoundStmt::const_body_iterator stmtIt;
        CompoundStmtIter iter;
        iter.stmt = fBody;
        iter.basicBlockHead = fBody->body_end();
        iter.basicBlockTail = fBody->body_end();
        
        for (stmtIt =fBody->body_begin(); stmtIt != fBody->body_end(); stmtIt++){
            ProcessStatement(info, stmtIt, &iter);
        }

        ProcessEndOfBasicBlock(info, &iter);

        ofstream funcJsonFile;
        std::string tmpDir = "./workspace/extract_hierarchy/";
        std::string jsonFileName = tmpDir + g_dirName + "/" + info->name + ".json";
        funcJsonFile.open(jsonFileName);
        if (funcJsonFile.is_open()) {
            json funcJson;
            OutputFunctionInfo(info, funcJson);
            funcJsonFile << std::setw(4) << funcJson;
            funcJsonFile << std::endl;
            funcJsonFile.close();
        }
        else {
            PRINT_DEBUG_MESSAGE("error - file not created - " + jsonFileName);
        }
    }
    return true;
}

unsigned FunctionAnalysisVisitor::OutputStatementInfo(StatementInfo* info, json& j) {
    SourceManager& sm = astContext->getSourceManager();
    j["range_begin"] = sm.getFileOffset(sm.getFileLoc(info->range.getBegin()));
    j["range_end"] = sm.getFileOffset(sm.getFileLoc(info->range.getEnd()));
    //std::string statementText;
    //raw_string_ostream wrap(statementText);
    //info->stmt->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
    //j["text"] = statementText;
    j["enabled"] = ENABLED;
    j["rhsstart"] = info->rhsStart;

    j["treeorder"] = json::array();
    j["subextype"] = json::array();
    j["isfloattype"] = json::array();

    for (int i = info->tree.size() - 1; i >= 0; i--) {
        if (info->tree[i].type == SUBEX_TYPE_OP || info->tree[i].type == SUBEX_TYPE_OTHER) {
            for (int j = i + 1; j < info->tree.size(); j++) {
                if (info->tree[j].parent == i && info->tree[j].isFloatType) {
                    info->tree[i].isFloatType = true;
                    break;
                }
            }
        }
    }

    for (int i = 0; i < info->tree.size(); i++) {
        j["treeorder"].push_back(info->tree[i].parent);
        j["subextype"].push_back(info->tree[i].type);
        j["isfloattype"].push_back(info->tree[i].isFloatType ? 1 : 0);
    }

    unsigned fpcount = info->reads.size() + info->writes.size() + info->decls.size() + info->consts.size() + info->calls.size();
    unsigned fpreads = info->reads.size();
    unsigned fpwrites = info->writes.size();
    unsigned fpcalls = info->calls.size();
    j["fpcount"] = fpcount;
    j["fpreads"] = fpreads;
    j["fpwrites"] = fpwrites;
    j["fpcalls"] = fpcalls;
    
    if (info->reads.size() != 0) {
        j["reads"] = json::array();
        for (auto& x : info->reads) {
            json read;
            read["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            read["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            read["name"] = x->getDecl()->getName();
            j["reads"].push_back(read);
        }
    }

    if (info->writes.size() != 0) {
        j["writes"] = json::array();
        for (auto& x : info->writes) {
            json write;
            write["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            write["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            write["name"] = x->getDecl()->getName();            
            j["writes"].push_back(write);
        }
    }

    if (info->decls.size() != 0) {
        j["decls"] = json::array();
        for (auto& x : info->decls) {
            json decl;
            decl["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            decl["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            decl["name"] = x->getName();                  
            j["decls"].push_back(decl);
        }
    }

    if (info->definitions.size() != 0) {
        j["definitions"] = json::array();
        for (auto& x : info->definitions) {
            json definitions;
            definitions["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            definitions["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            definitions["name"] = x->getName();                  
            j["definitions"].push_back(definitions);
        }
    }

    if (info->consts.size() != 0) {
        j["consts"] = json::array();
        for (auto& x : info->consts) {
            json constant;
            constant["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            constant["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            j["consts"].push_back(constant);
        }
    }

    if (info->calls.size() != 0) {
        j["calls"] = json::array();
        for (auto& x : info->calls) {
            json call;
            call["range_begin"] = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getBegin()));
            call["range_end"]  = sm.getFileOffset(sm.getFileLoc(x->getSourceRange().getEnd()));
            call["name"] = x->getDirectCallee()->getNameInfo().getName().getAsString();                 
            j["calls"].push_back(call);
        }
    }

    return fpcount;
}

unsigned FunctionAnalysisVisitor::OutputBasicBlockInfo(BasicBlockInfo* info, json& j) {
    SourceManager& sm = astContext->getSourceManager();
    j["range_begin"] = sm.getFileOffset(sm.getFileLoc(info->range.getBegin()));
    j["range_end"] = sm.getFileOffset(sm.getFileLoc(info->range.getEnd()));
    j["type"] = info->blockType;
    j["enabled"] = ENABLED;
    unsigned fpcount = 0;
    unsigned fpreads = 0;
    unsigned fpwrites = 0;
    unsigned fpcalls = 0;

    if (info->blocks.size() != 0) {
        j["blocks"] = json::array();
        for (auto& x : info->blocks) {
            json block_json;
            unsigned count = OutputBasicBlockInfo(&x, block_json);
            j["blocks"].push_back(block_json);
            fpcount += count;
            fpreads += (unsigned)block_json["fpreads"];
            fpwrites += (unsigned)block_json["fpwrites"];
            fpcalls += (unsigned)block_json["fpcalls"];
        }
    }

    if (info->statements.size() != 0) {
        j["stmts"] = json::array();
        for (auto& x : info->statements) {
            json stmt_json;
            unsigned count = OutputStatementInfo(&x, stmt_json);
            j["stmts"].push_back(stmt_json);
            fpcount += count;
            fpreads += (unsigned)stmt_json["fpreads"];
            fpwrites += (unsigned)stmt_json["fpwrites"];
            fpcalls += (unsigned)stmt_json["fpcalls"];
        }
    }

    j["fpcount"] = fpcount;
    j["fpreads"] = fpreads;
    j["fpwrites"] = fpwrites;
    j["fpcalls"] = fpcalls;
    return fpcount;
}

void FunctionAnalysisVisitor::OutputFunctionInfo(FunctionInfo* info, json& j) {
    j["name"] = info->name;
    OutputBasicBlockInfo(info, j); 
}

void FunctionAnalysisASTConsumer::HandleTranslationUnit(ASTContext &Context) {
    // insert macro at the beginning of the file
    FileID id = rewriter.getSourceMgr().getMainFileID();    
    string originalFilename = rewriter.getSourceMgr().getFilename(rewriter.getSourceMgr().getLocForStartOfFile(id)).str();
    // write original file info to file
    string marker = "// " + originalFilename + "\n";

    std::string basefilename = basename(originalFilename);
    string filename = "./workspace/original_files/" + basefilename;

    // save original files (but with a marker)
    {
        rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), marker);

        // Create an output file to write the updated code
        std::error_code OutErrorInfo;
        std::error_code ok;
        const RewriteBuffer *RewriteBuf = rewriter.getRewriteBufferFor(id);
        if (RewriteBuf) {
            llvm::raw_fd_ostream outFile(llvm::StringRef(filename),
                OutErrorInfo, llvm::sys::fs::OF_None);
            if (OutErrorInfo == ok) {
                outFile << std::string(RewriteBuf->begin(), RewriteBuf->end());
                PRINT_DEBUG_MESSAGE("Output file created - " << filename);
            } else {
                PRINT_DEBUG_MESSAGE("Could not create file - " << filename);
            }
        }
    }

    visitor->TraverseDecl(Context.getTranslationUnitDecl());
}

unique_ptr<ASTConsumer> PluginFunctionAnalysisAction::CreateASTConsumer(CompilerInstance &CI, StringRef file) {
    PRINT_DEBUG_MESSAGE("Filename: " << file.str());

    g_mainFilename = file.str();
    g_dirName = basename(g_mainFilename);
    size_t dotpos = g_dirName.find(".");
    if (dotpos != std::string::npos)
        g_dirName = g_dirName.replace(dotpos, 1, "_");
    std::string tmpDir = "./workspace/extract_hierarchy/";
    mkdir((tmpDir + g_dirName).c_str(), 0777);

    // read setup.ini
    ifstream setupFile("./setup.ini");
    if (setupFile.is_open()) {
        string s;
        while (getline(setupFile, s)) {
            PRINT_DEBUG_MESSAGE("line: " << s);
            if (s.find("UseExtendedPrecision") != std::string::npos)
                useExtendedPrecision = string_to_lower(s).find("yes") != std::string::npos;
            if (s.find("SearchInHeaders") != std::string::npos)
                searchInHeaders = string_to_lower(s).find("yes") != std::string::npos;
            if (s.find("SearchInHostFunctions") != std::string::npos)
                searchInHostFunctions = string_to_lower(s).find("yes") != std::string::npos;
        }
        setupFile.close();
    }

    if (CI.getLangOpts().LangStd == LangStandard::Kind::lang_cuda) {
        PRINT_DEBUG_MESSAGE("CUDA language detected");
        std::string basefilename = basename(g_mainFilename);
        string markerFileName = "./plugin_run_fa_";
        markerFileName = markerFileName + basefilename;
        ifstream pluginRunFile(markerFileName);
        if (pluginRunFile.is_open()) {
            pluginRunFile.close();
            remove(markerFileName.c_str());
            exit(0);
        }
        else {
            ofstream pluginRunFile(markerFileName);
            pluginRunFile << "touch" << std::endl;
            pluginRunFile.close();
        }
    }

    return make_unique<FunctionAnalysisASTConsumer>(&CI);
}
 
bool PluginFunctionAnalysisAction::ParseArgs(const CompilerInstance &CI, const vector<string> &args) {
    return true;
}