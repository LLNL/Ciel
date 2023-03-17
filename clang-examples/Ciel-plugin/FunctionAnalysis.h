#pragma once

using namespace std;
using namespace clang;
using namespace llvm;

extern string g_mainFilename;
extern string g_dirName;
extern Rewriter rewriter;

class FunctionAnalysisVisitor : public RecursiveASTVisitor<FunctionAnalysisVisitor> {
private:
    ASTContext *astContext; // used for getting additional AST info

    std::map<std::string, FunctionInfo*> funcInfos;
    StatementInfo* traversingSingleStatement = NULL;

    const Stmt* anchorPointForRHS = NULL;

    StatementInfo CreateStatementInfo(const Stmt* st);

    void ProcessStatement(BasicBlockInfo* info, CompoundStmt::const_body_iterator stmtIt, CompoundStmtIter* stmtIter);
    void ProcessEndOfBasicBlock(BasicBlockInfo* info, CompoundStmtIter* iter);
    void ProcessCompoundStatement(BasicBlockInfo* parentInfo, BasicBlockInfo& basicBlock, const CompoundStmt* compoundStmt);

    std::string SourceRangeToString(SourceRange range);

    void OutputFunctionInfo(FunctionInfo* info, json& j);
    unsigned OutputBasicBlockInfo(BasicBlockInfo* info, json& j);
    unsigned OutputStatementInfo(StatementInfo* info, json& j);

public:
    explicit FunctionAnalysisVisitor(CompilerInstance *CI)
        : astContext(&(CI->getASTContext())) // initialize private members
    {
        rewriter.setSourceMgr(astContext->getSourceManager(),
            astContext->getLangOpts());     
        funcInfos.clear();
    }
 
    virtual bool VisitFunctionDecl(FunctionDecl* func);
    virtual bool VisitStmt(Stmt* st);
};

class FunctionAnalysisASTConsumer : public ASTConsumer {
private:
    FunctionAnalysisVisitor *visitor; // doesn't have to be private

public:
    explicit FunctionAnalysisASTConsumer(CompilerInstance *CI)
        : visitor(new FunctionAnalysisVisitor(CI)) // initialize the visitor
        { }
 
    virtual void HandleTranslationUnit(ASTContext &Context);
};

class PluginFunctionAnalysisAction : public PluginASTAction {
protected:
    unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI, StringRef file); 
    bool ParseArgs(const CompilerInstance &CI, const vector<string> &args);
};
