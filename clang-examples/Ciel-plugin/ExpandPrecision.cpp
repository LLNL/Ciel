#include <iostream>
#include <string>
#include <unistd.h>

#include "utils.h"
#include "ExpandPrecision.h"

#define AUTO_ARRAY_TRANSFORM 0

void ExpandPrecisionVisitor::ResetTraversal(int pass) {
    currentPass = pass;
    currentRange = RANGE_OUT;
    currentRegion = 0;
    if (currentPass == 1) {
        funcTypes.clear();
        mergedRegionsInStmt.clear();
    }        
    PRINT_DEBUG_MESSAGE("current pass: " << currentPass);
}

TypeLoc ExpandPrecisionVisitor::GetInnermostTypeLoc(TypeLoc loc) {
    ArrayTypeLoc arrTypeLoc = loc.getAs<ArrayTypeLoc>();
    PointerTypeLoc ptrTypeLoc = loc.getAs<PointerTypeLoc>();
    if (arrTypeLoc.isNull() == false) {
        return GetInnermostTypeLoc(arrTypeLoc.getElementLoc());
    }
    else if (ptrTypeLoc.isNull() == false) {
        return GetInnermostTypeLoc(ptrTypeLoc.getPointeeLoc());
    }
    return loc;
}

string ExpandPrecisionVisitor::FindReplaceMathFunctionName(string funcName) {
    size_t funcLength = funcName.length();
    int mathFuncPrecision = -1;
    if (funcName[funcName.size() - 1] == 'f') {
        mathFuncPrecision = 4;
        funcName = funcName.substr(0, funcName.size() - 1);
    }
    else if (funcName[funcName.size() - 1] == 'l') {
        mathFuncPrecision = 16;
        funcName = funcName.substr(0, funcName.size() - 1);
    }
    else {
        mathFuncPrecision = 8;
    }
    // REWRITE math functions
    if (mathcalls_base.find(funcName) != mathcalls_base.end()) {
        string funcNameToReplace = "";
        if (useExtendedPrecision) {
            if (currentFuncType == FUNC_TYPE_HOST) {
                funcNameToReplace = mathcalls_base.find(funcName)->second;
            }
            else if (mathFuncPrecision == 4) {
                funcNameToReplace = mathcalls_base.find(funcName)->first;
            }
        }
        else {
            funcNameToReplace = mathcalls_base.find(funcName)->first;
        }

        return funcNameToReplace;
    }

    return "";
}

bool ExpandPrecisionVisitor::ProcessMathFunctions(const DeclRefExpr* call, bool convertToOriginal) {
    const ValueDecl* valueDecl = call->getDecl();

    if (const FunctionDecl* funcDecl = dyn_cast<FunctionDecl>(valueDecl)) {
        std::string funcName;
        raw_string_ostream wrap(funcName);
        call->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));        
        size_t funcLength = funcName.length();
        string funcNameToReplace = FindReplaceMathFunctionName(funcName);
        if (funcNameToReplace != "") {
            if (convertToOriginal) {
                string returnTypeString = funcDecl->getReturnType().getAsString();
                rewriter.ReplaceText(call->getBeginLoc(), funcLength, "(" + returnTypeString + ")" + funcNameToReplace);
            }
            else
                rewriter.ReplaceText(call->getBeginLoc(), funcLength, funcNameToReplace);
            return true;
        }
    }
    return false;
}

bool ExpandPrecisionVisitor::ProcessMathFunctions(const CallExpr* call) {
    if (call->getDirectCallee()) {
        string funcName = call->getDirectCallee()->getNameInfo().getAsString();
        size_t funcLength = funcName.length();
        string funcNameToReplace = FindReplaceMathFunctionName(funcName);
        if (funcNameToReplace != "") {
            rewriter.ReplaceText(call->getExprLoc(), funcLength, funcNameToReplace);
            return true;
        }
    }
    return false;
}

void ExpandPrecisionVisitor::AnalyzeBlocks(json& j, BasicBlockInfo& info) {
    info.blocks.resize(j["blocks"].size());
    bool blockAllEnabled = true;
    for (unsigned int i = 0; i < j["blocks"].size(); i++) {
        BasicBlockInfo* subBlockInfo = &info.blocks[i];
        
        SourceLocation beginLoc = fileStart.getLocWithOffset(j["blocks"][i]["range_begin"]);
        SourceLocation endLoc = fileStart.getLocWithOffset(j["blocks"][i]["range_end"]);
        SourceRange transformRange;
        transformRange.setBegin(beginLoc);
        transformRange.setEnd(endLoc);
        subBlockInfo->range = transformRange;
        subBlockInfo->blockType = j["blocks"][i]["type"];
        subBlockInfo->enabled = j["blocks"][i]["enabled"];
        
        bool isIndividualEnabled = j["blocks"][i]["enabled"] == INDIVIDUAL_ENABLED;

        if (j["blocks"][i].contains("blocks")) {
            AnalyzeBlocks(j["blocks"][i], *subBlockInfo);
        }
        else {
            AnalyzeStatements(j["blocks"][i], *subBlockInfo);
        }
        blockAllEnabled &= subBlockInfo->enabled == ENABLED;  
        if (isIndividualEnabled) {
            subBlockInfo->enabled = INDIVIDUAL_ENABLED;
        }          
    }
    if (info.enabled != DISABLED && blockAllEnabled == false) {
        info.enabled = PARTIAL_ENABLED;
    }
}

void ExpandPrecisionVisitor::AnalyzeStatements(json& j, BasicBlockInfo& info) {
    if (!j.contains("stmts"))
        return;
    info.statements.resize(j["stmts"].size());
    bool blockAllEnabled = true;
    for (unsigned int i = 0; i < j["stmts"].size(); i++) {
        StatementInfo* stmtInfo = &info.statements[i];

        PRINT_DEBUG_MESSAGE("begin: " << int(j["stmts"][i]["range_begin"]) << " end: " << int(j["stmts"][i]["range_end"]) << " tree size: " << j["stmts"][i]["treeorder"].size());
        SourceLocation beginLoc = fileStart.getLocWithOffset(j["stmts"][i]["range_begin"]);
        SourceLocation endLoc = fileStart.getLocWithOffset(j["stmts"][i]["range_end"]);
        SourceRange transformRange;
        transformRange.setBegin(beginLoc);
        transformRange.setEnd(endLoc);
        stmtInfo->range = transformRange;

        stmtInfo->stmtElement = j["stmts"][i];
        stmtInfo->enabled = j["stmts"][i]["enabled"];
        stmtInfo->rhsStart = j["stmts"][i]["rhsstart"];
        blockAllEnabled &= stmtInfo->enabled == ENABLED;

        stmtInfo->tree.clear();
        for (int idx = 0; idx < j["stmts"][i]["treeorder"].size(); idx++) {
            StatementTreeNode node;
            node.parent = j["stmts"][i]["treeorder"][idx];
            node.type = j["stmts"][i]["subextype"][idx];
            node.stmt = NULL; // placeholder
            node.isFloatType = int(j["stmts"][i]["isfloattype"][idx]) ? true : false;
            stmtInfo->tree.push_back(node);
        }
    }
    if (info.enabled != DISABLED && blockAllEnabled == false) {
        info.enabled = PARTIAL_ENABLED;
    }
}

bool ExpandPrecisionVisitor::PrintEnabledStatementsInBlocks(json& root, BasicBlockInfo& info, bool alreadyEnabled, std::ostream& outFile) {
    bool continousStatements = false;
    for (unsigned int i = 0; i < info.blocks.size(); i++) {
        statementIndices.push_back(i);
        switch (info.blocks[i].enabled) {
            case ENABLED: 
            case INDIVIDUAL_ENABLED:
            {
                if (info.blocks[i].blocks.size() == 0) {
                    continousStatements |= PrintEnabledStatementsInStatements(root, info.blocks[i], true, outFile);
                }
                else {
                    continousStatements |= PrintEnabledStatementsInBlocks(root, info.blocks[i], true, outFile);
                }
            }
            break;
            case PARTIAL_ENABLED:
            {
                if (info.blocks[i].blocks.size() == 0) {
                    continousStatements |= PrintEnabledStatementsInStatements(root, info.blocks[i], alreadyEnabled, outFile);
                }
                else {
                    continousStatements |= PrintEnabledStatementsInBlocks(root, info.blocks[i], alreadyEnabled, outFile);
                }
            }
            break;
            default:
            {
                if (alreadyEnabled) {
                    if (info.blocks[i].blocks.size() == 0) {
                        continousStatements |= PrintEnabledStatementsInStatements(root, info.blocks[i], true, outFile);
                    }
                    else {
                        continousStatements |= PrintEnabledStatementsInBlocks(root, info.blocks[i], true, outFile);
                    }   
                }
            }
            break;
        }
        statementIndices.pop_back();
    }
    return continousStatements;
}

bool ExpandPrecisionVisitor::PrintEnabledStatementsInStatements(json& root, BasicBlockInfo& info, bool alreadyEnabled, std::ostream& outFile) {
    bool lastEnabled = false;
    bool continuousStatements = false;
    for (unsigned int i = 0; i < info.statements.size(); i++) {
        if (lastEnabled && (info.statements[i].enabled == ENABLED || alreadyEnabled)) {
            continuousStatements = true;
        }
        statementIndices.push_back(i);
        lastEnabled = false;
        if (info.statements[i].enabled == ENABLED || alreadyEnabled) {
            PrintSourceRangeToFile(info.statements[i].range, astContext, resFile);
            outFile << traversingFunc << ";";
            for (int idx = 0; idx < statementIndices.size(); idx++) {
                outFile << statementIndices[idx];
                if (idx != statementIndices.size() - 1)
                    outFile << ",";
            }
            outFile << ";" << info.statements[i].rhsStart << ";";
            for (int idx = 0; idx < info.statements[i].tree.size(); idx++) {
                outFile << info.statements[i].tree[idx].parent;
                if (idx != info.statements[i].tree.size() - 1) 
                    outFile << ",";
            }
            outFile << ";";
            for (int idx = 0; idx < info.statements[i].tree.size(); idx++) {
                outFile << info.statements[i].tree[idx].type;
                if (idx != info.statements[i].tree.size() - 1) 
                    outFile << ",";
            }
            outFile << std::endl;
            lastEnabled = true;
        }
        statementIndices.pop_back();
    }
    return continuousStatements;
}

void ExpandPrecisionVisitor::FindRegionsInBlocks(json& root, BasicBlockInfo& info, vector<RegionInRange>& regions) {
    RegionInRange item;
    bool inCompoundBlock = info.blockType == BLOCK_TYPE_LOOP || info.blockType == BLOCK_TYPE_COND;
    for (unsigned int i = 0; i < info.blocks.size(); i++) {
        if (subExpressionIsolation) {
            statementIndices.push_back(i);
            if (info.blocks[i].blocks.size() == 0) {
                FindRegionsInStatements(root, info.blocks[i], regions);
            }
            else {
                FindRegionsInBlocks(root, info.blocks[i], regions);
            }
            statementIndices.pop_back();
            continue;
        }
        
        item.compoundBlock = (inCompoundBlock && i != 0); // TODO: for do-while
        switch (info.blocks[i].enabled) {
            case ENABLED: 
            {
                if (startLocationValid == false) {
                    startLocationValid = true;
                    regionStartLocation = info.blocks[i].range.getBegin();
                }

                // last block processing
                if (i == info.blocks.size() - 1 || item.compoundBlock) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.blocks[i].range.getEnd());
                    item.endOfBlock = END_OF_BLOCK_NORMAL;
                    regions.push_back(item);                    
                }
            }
            break;
            case INDIVIDUAL_ENABLED:
            {
                if (startLocationValid == true) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.blocks[i].range.getBegin());
                    item.endOfBlock = END_OF_BLOCK_FALSE;
                    regions.push_back(item);
                }     

                // last block processing
                if (i == info.blocks.size() - 1 || item.compoundBlock) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.blocks[i].range.getEnd());
                    item.endOfBlock = END_OF_BLOCK_NORMAL;
                    regions.push_back(item);                         
                }
                else {
                    // itself as a region
                    item.range = info.blocks[i].range;
                    item.endOfBlock = END_OF_BLOCK_FALSE;
                    regions.push_back(item);    
                }    
            }
            break;
            case DISABLED:
            case PARTIAL_ENABLED:
            {
                item.compoundBlock = false;
                if (startLocationValid == true) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.blocks[i].range.getBegin());
                    item.endOfBlock = END_OF_BLOCK_FALSE;
                    regions.push_back(item);
                }

                if (info.blocks[i].enabled == PARTIAL_ENABLED) {
                    // enter the sub block
                    if (info.blocks[i].blocks.size() == 0) {
                        FindRegionsInStatements(root, info.blocks[i], regions);
                    }
                    else {
                        FindRegionsInBlocks(root, info.blocks[i], regions);
                    }
                }
            }
            break;
        }
    }
}

void ExpandPrecisionVisitor::FindRegionsInStatements(json& root, BasicBlockInfo& info, vector<RegionInRange>& regions) {
    RegionInRange item;
    item.compoundBlock = false;
    for (unsigned int i = 0; i < info.statements.size(); i++) {
        if (subExpressionIsolation) {
            if (currentStatementIndex >= subExpressionIsolationInfos.size())
                continue;
                
            statementIndices.push_back(i);
            if (subExpressionIsolationInfos[currentStatementIndex].stmtIndices.size() == statementIndices.size()) {
                bool sameStatement = true;
                for (int j = 0; j < statementIndices.size(); j++) {
                    PRINT_DEBUG_MESSAGE("-> compare " << j);
                    if (subExpressionIsolationInfos[currentStatementIndex].stmtIndices[j] != statementIndices[j]) {
                        sameStatement = false;
                        break;
                    }
                }
                if (sameStatement) {
                    subExpressionIsolationInfos[currentStatementIndex].range = info.statements[i].range;
                    PRINT_DEBUG_MESSAGE("subexpression " << currentStatementIndex);
                    PrintSourceRange(info.statements[i].range, astContext);
                    currentStatementIndex++;
                }
            }
            statementIndices.pop_back();
            continue;
        }
        switch (info.statements[i].enabled) {
            case ENABLED: 
            {
                if (startLocationValid == false) {
                    startLocationValid = true;
                    regionStartLocation = info.statements[i].range.getBegin();
                }

                if (i == info.statements.size() - 1) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.statements[i].range.getEnd());
                    if (info.blockType == BLOCK_TYPE_BASIC)
                        item.endOfBlock = END_OF_BLOCK_FLAT_COMPOUND;
                    else
                        item.endOfBlock = END_OF_BLOCK_NORMAL;
                    regions.push_back(item);   
                }
            }
            break;
            case DISABLED:
            case PARTIAL_ENABLED:
            {
                if (startLocationValid == true) {
                    startLocationValid = false;
                    item.range.setBegin(regionStartLocation);
                    item.range.setEnd(info.statements[i].range.getBegin());
                    item.endOfBlock = END_OF_BLOCK_FALSE;
                    regions.push_back(item);                    
                }
            }
            break;
        }
    }
}

void ExpandPrecisionVisitor::SetTransformRegions(string func, json& j) {
    if (j.contains("placeholder"))
        return;

    string dictId = j.contains("blocks") ? "blocks" : "stmts";
    unsigned transformRegionBegin = j["range_begin"];
    unsigned transformRegionEnd = j["range_end"];
    SourceLocation beginLoc = fileStart.getLocWithOffset(transformRegionBegin);
    SourceLocation endLoc = fileStart.getLocWithOffset(transformRegionEnd);
    SourceRange transformRange;
    transformRange.setBegin(beginLoc);
    transformRange.setEnd(endLoc);
    regionInfos[func].range = transformRange;
    PRINT_DEBUG_MESSAGE("func begin: " << transformRegionBegin << " end: " << transformRegionEnd);
    PRINT_DEBUG_MESSAGE("func region begin: " << transformRegionBegin << " end: " << transformRegionEnd);
    
    // analyze read/writes
    if (dictId == "blocks") {
        regionInfos[func].blockType = BLOCK_TYPE_FUNC;
        AnalyzeBlocks(j, regionInfos[func]);
    }
    else {
        regionInfos[func].blockType = BLOCK_TYPE_BASIC;
        AnalyzeStatements(j, regionInfos[func]);
    }

    mergedRegions[func].clear();
    startLocationValid = false;

    traversingFunc = func;

    // analyze regions
    if (dictId == "blocks") {
        regionInfos[func].blockType = BLOCK_TYPE_FUNC;
        FindRegionsInBlocks(j, regionInfos[func], mergedRegions[func]);
    }
    else {
        regionInfos[func].blockType = BLOCK_TYPE_BASIC;
        FindRegionsInStatements(j, regionInfos[func], mergedRegions[func]);
    }

    if (currentMode == TRANSFORM_PRINT_ONLY) {        
        if (resFile.is_open()) {        
            for (auto& region : mergedRegions[func]) {
                PrintSourceRangeToFile(region.range, astContext, resFile);
            }

            std::fstream subExFile;
            subExFile.open("./subex_isolation.out", std::fstream::in | std::fstream::out | std::fstream::app);
            
            statementIndices.clear();
            resFile << "Individual statements: " << std::endl;
            bool continuousStatements = false;
            if (subExFile.is_open()) {
                // analyze regions
                if (dictId == "blocks") {
                    continuousStatements = PrintEnabledStatementsInBlocks(j, regionInfos[func], false, subExFile);
                }
                else {
                    continuousStatements = PrintEnabledStatementsInStatements(j, regionInfos[func], false, subExFile);
                }     
                subExFile.close();       
            }
            statementIndices.clear();
            resFile << "Has continuous statements: " << (continuousStatements ? "yes" : "no") << std::endl;
        }
    }
    else if (!subExpressionIsolation) {
        for (auto& region : mergedRegions[func]) {
            PrintSourceRange(region.range, astContext);
            PRINT_DEBUG_MESSAGE("\tend of block: " << region.endOfBlock << "\n\tcompound block: " << region.compoundBlock);
        }
    }
    traversingFunc = "";
}

void ExpandPrecisionVisitor::openResultFile() {
    resFile.open("./results.out", std::ofstream::out | std::ofstream::app);
    resFile << "Print result: " << std::endl;
}

void ExpandPrecisionVisitor::closeResultFile() {
    resFile.close();
}   

bool ExpandPrecisionVisitor::Block_ProcessStmtFirstPass(Stmt* st) {
    SourceRange locRange = st->getSourceRange();
    unsigned locBegin = sm->getFileOffset(sm->getFileLoc(locRange.getBegin()));
    unsigned locEnd = sm->getFileOffset(sm->getFileLoc(locRange.getEnd()));

    PRINT_DEBUG_MESSAGE("checking stmt begin " << locBegin << " end " << locEnd);

    BasicBlockInfo* block = &regionInfos[traversingFunc];
    StatementInfo* statement = NULL;

    unsigned int regionIndex = currentRegion / 2;
    bool beginConverted = currentRegion % 2;

    if (regionIndex >= mergedRegions[traversingFunc].size())
        return true;

    SourceLocation regionLoc = beginConverted ? mergedRegions[traversingFunc][regionIndex].range.getEnd() : mergedRegions[traversingFunc][regionIndex].range.getBegin();
    unsigned regionLocOffset = sm->getFileOffset(sm->getFileLoc(regionLoc));
    // end of block processing: move one character after
    if (beginConverted && mergedRegions[traversingFunc][regionIndex].endOfBlock) {
        regionLocOffset++;
    }

    if (currentRange == RANGE_ENTRY || currentRange == RANGE_EXITENTRY) {
        currentRange = RANGE_IN;
    }
    else if (currentRange == RANGE_EXIT) {
        currentRange = RANGE_OUT;
    }

    bool willReturn = false;

    if (beginConverted && regionLocOffset <= locBegin) {
        mergedRegionsInStmt[traversingFunc][regionIndex].end = st;
        currentRange = RANGE_EXIT;
        PRINT_DEBUG_MESSAGE("exit region " << regionIndex << " " << regionLocOffset);
        currentRegion++;

        // debug print all variable in list
        PRINT_DEBUG_MESSAGE("in region " << (currentRegion / 2 - 1));
        PRINT_DEBUG_MESSAGE("external array/pointer: " << extReference->size());
        for (const VarDecl* varDecl : *extReference) {
            PRINT_DEBUG_MESSAGE("\t" << varDecl->getName());
        }

        // collect variables to be cast
        for (const VarDecl* item : currReads) {
            if (visited.find(item) == visited.end()) {
                castVars->insert(item);
            }
        }                    

        PRINT_DEBUG_MESSAGE("variables to cast: " << castVars->size());
        for (const VarDecl* item : *castVars) {
            PRINT_DEBUG_MESSAGE("\t" << item->getName());
        }

        // collect variables as write only
        for (const VarDecl* item : currWrites) {
            if (visited.find(item) == visited.end()) {
                bool woSet = false;
                if (item->getTypeSourceInfo()) {
                    TypeLoc typeLoc = item->getTypeSourceInfo()->getTypeLoc();
                    FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);

                    if (!info.isSimpleFPType()) {
                        writeOnlyVars->insert(item);
                        woSet = true;
                    }
                }
                if (!woSet) {
                    if (currDefinitions.find(item) == currDefinitions.end()) {
                        replaceVars->insert(item);
                    }
                    else
                        reviseVars->insert(std::pair<const VarDecl*, std::string>(item, item->getName().str()));
                }     
            }                 
        }

        PRINT_DEBUG_MESSAGE("variables to cast back: " << writeOnlyVars->size());
        for (const VarDecl* item : *writeOnlyVars) {
            PRINT_DEBUG_MESSAGE("\t" << item->getName());
        }        

        PRINT_DEBUG_MESSAGE("variables to revise: " << reviseVars->size());
        for (auto const& item : *reviseVars) {
            PRINT_DEBUG_MESSAGE("\t" << item.second);
        }

        PRINT_DEBUG_MESSAGE("variables to replace: " << replaceVars->size());
        for (const VarDecl* varDecl : *replaceVars) {
            PRINT_DEBUG_MESSAGE("\t" << varDecl->getName());
        }

        currReads.clear();
        currWrites.clear();
        currDefinitions.clear();
        visited.clear();

        reviseVars = NULL;
        replaceVars = NULL;
        castVars = NULL;
        extReference = NULL;
        writeOnlyVars = NULL;

        regionIndex = currentRegion / 2;
        beginConverted = currentRegion % 2;

        regionLoc = beginConverted ? mergedRegions[traversingFunc][regionIndex].range.getEnd() : mergedRegions[traversingFunc][regionIndex].range.getBegin();
        regionLocOffset = sm->getFileOffset(sm->getFileLoc(regionLoc));

        if (regionLocOffset == locBegin) {
            RegionInStmt region;
            region.begin = st;
            region.end = NULL;
            region.regionType = REGION_TYPE_ADJACENT_START;
            mergedRegionsInStmt[traversingFunc].back().regionType = REGION_TYPE_ADJACENT_EXIT;
            mergedRegionsInStmt[traversingFunc].push_back(region);

            currentRange = RANGE_EXITENTRY;
            PRINT_DEBUG_MESSAGE("immediately enter a region after exit");
            currentRegion++;
            PRINT_DEBUG_MESSAGE("enter region (again) " << regionIndex << " " << regionLocOffset);
        }
        else
            willReturn = true;                
    }
    else if (!beginConverted && regionLocOffset == locBegin) {
        RegionInStmt region;
        region.regionType = REGION_TYPE_NORMAL;
        region.begin = st;
        region.end = NULL;
        mergedRegionsInStmt[traversingFunc].push_back(region);

        currentRange = RANGE_ENTRY;

        PRINT_DEBUG_MESSAGE("enter region " << regionIndex << " " << regionLocOffset);

        currentRegion++;
    }

    if (currentRange == RANGE_OUT) {
        willReturn = true;
    }
    
    if (currentRange == RANGE_ENTRY || currentRange == RANGE_EXITENTRY) {
        currReads.clear();
        currWrites.clear();
        currDefinitions.clear();
        visited.clear();

        unsigned int regionIndex = currentRegion / 2;

        PRINT_DEBUG_MESSAGE("set region " << regionIndex << " variable categorization");

        reviseVars = &mergedRegionsInStmt[traversingFunc][regionIndex].reviseVars;
        replaceVars = &mergedRegionsInStmt[traversingFunc][regionIndex].replaceVars;
        castVars = &mergedRegionsInStmt[traversingFunc][regionIndex].castVars;
        extReference = &mergedRegionsInStmt[traversingFunc][regionIndex].extReference;
        writeOnlyVars = &mergedRegionsInStmt[traversingFunc][regionIndex].writeOnlyVars;
    }

    bool outOfBounds = false;
    bool isComplexStatement = IsComplexStatement(st);
    while (true) {
        unsigned outBlockBegin = sm->getFileOffset(sm->getFileLoc(block->range.getBegin()));
        unsigned outBlockEnd = sm->getFileOffset(sm->getFileLoc(block->range.getEnd()));
        if (outBlockBegin == locBegin && outBlockEnd == locEnd) {
            PRINT_DEBUG_MESSAGE("\tfound the block");
            block->compoundStmt = st;

            if (isComplexStatement)
                break;
        }

        if (block->blocks.size() == 0) {
            bool foundStmt = false;
            for (unsigned int i = 0; i < block->statements.size(); i++) {
                unsigned stmtBegin = sm->getFileOffset(sm->getFileLoc(block->statements[i].range.getBegin()));
                unsigned stmtEnd = sm->getFileOffset(sm->getFileLoc(block->statements[i].range.getEnd()));
                if (locBegin >= stmtBegin && locEnd <= stmtEnd) {
                    statement = &block->statements[i];
                    foundStmt = true;
                    if (locBegin == stmtBegin && locEnd == stmtEnd && statement->stmt == NULL) {
                        PRINT_DEBUG_MESSAGE("\tfound the statement");
                        statement->stmt = st;
                    }
                    break;
                }
            }

            if (!foundStmt) {
                // likely a macro expansion, ignore
                willReturn = true;
                break;
            }
            else if (statement->enabled == DISABLED) {
                outOfBounds = true;
                break;
            }
            break;                    
        }
        else {
            bool foundBlock = false;
            for (unsigned int i = 0; i < block->blocks.size(); i++) {
                unsigned blockBegin = sm->getFileOffset(sm->getFileLoc(block->blocks[i].range.getBegin()));
                unsigned blockEnd = sm->getFileOffset(sm->getFileLoc(block->blocks[i].range.getEnd()));
                if (locBegin >= blockBegin && locEnd <= blockEnd) {
                    block = &block->blocks[i];
                    foundBlock = true;
                    break;
                }
            }

            if (!foundBlock) {
                // likely a macro expansion, ignore
                willReturn = true;
                break;
            }
            else if (block->enabled == DISABLED) {
                outOfBounds = true;
                break;
            }
        }
    }

    if (isComplexStatement || willReturn) {                
        return true;
    }

    if (outOfBounds)
        return true;

    // analyze stmt elements (reads writes etc.)
    // reads
    if (DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
        PRINT_DEBUG_MESSAGE("found a DeclRefExpr");
        if (statement->stmtElement.contains("reads")) {
            for (unsigned int i = 0; i < statement->stmtElement["reads"].size(); i++) {                    
                if (locBegin == statement->stmtElement["reads"][i]["range_begin"]) {
                    statement->reads.push_back(declRefExpr);
                    const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
                    currReads.insert(varDecl);
                    PRINT_DEBUG_MESSAGE("added to currReads " << locBegin);
                    if (currWrites.find(varDecl) != currWrites.end()) {
                        if (currDefinitions.find(varDecl) != currDefinitions.end()) {
                            reviseVars->insert(std::pair<const VarDecl*, std::string>(varDecl, varDecl->getName().str()));
                            
                            PRINT_DEBUG_MESSAGE("added to reviseVars " << sm->getFileOffset(sm->getFileLoc(varDecl->getBeginLoc())));
                        }
                        else {
                            if (varDecl->getTypeSourceInfo()) {
                                TypeLoc typeLoc = varDecl->getTypeSourceInfo()->getTypeLoc();
                                FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);

                                if (!info.isSimpleFPType()) {
                                    extReference->insert(varDecl);
                                    PRINT_DEBUG_MESSAGE("added to extReference " << locBegin);
                                }
                                else {
                                    replaceVars->insert(varDecl);
                                    PRINT_DEBUG_MESSAGE("added to replaceVars " << locBegin);
                                }
                            }
                            else {
                                replaceVars->insert(varDecl);
                                PRINT_DEBUG_MESSAGE("added to replaceVars " << locBegin);
                            }
                        }
                        visited.insert(varDecl);
                    }
                    break;
                }
            }
        }

        if (statement->stmtElement.contains("writes")) {
            const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
            for (unsigned int i = 0; i < statement->stmtElement["writes"].size(); i++) {
                if (locBegin == statement->stmtElement["writes"][i]["range_begin"]) {
                    statement->writes.push_back(declRefExpr);
                    currWrites.insert(varDecl);
                    PRINT_DEBUG_MESSAGE("added to currWrites " << locBegin);

                    // get parent to check if it is a compound assignment. If so, add to read as well
                    const auto& parents = astContext->getParents(*declRefExpr);
                    if (parents.empty())
                        break;
                    const Expr* parentExpr = parents[0].get<Expr>();
                    if (!parentExpr)
                        break;

                    const Expr* lhs;
                    const Expr* rhs;
                    FindCompoundAssignment(parentExpr, &lhs, &rhs);
                    if (lhs) {
                        currReads.insert(varDecl);

                        if (currDefinitions.find(varDecl) != currDefinitions.end()) {
                            reviseVars->insert(std::pair<const VarDecl*, std::string>(varDecl, varDecl->getName().str()));
                            
                            PRINT_DEBUG_MESSAGE("added to reviseVars " << sm->getFileOffset(sm->getFileLoc(varDecl->getBeginLoc())));
                        }
                        else {
                            if (varDecl->getTypeSourceInfo()) {
                                TypeLoc typeLoc = varDecl->getTypeSourceInfo()->getTypeLoc();
                                FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);

                                if (!info.isSimpleFPType()) {
                                    extReference->insert(varDecl);
                                    PRINT_DEBUG_MESSAGE("added to extReference " << locBegin);
                                }
                                else {
                                    replaceVars->insert(varDecl);
                                    PRINT_DEBUG_MESSAGE("added to replaceVars " << locBegin);
                                }
                            }
                            else {
                                replaceVars->insert(varDecl);
                                PRINT_DEBUG_MESSAGE("added to replaceVars " << locBegin);
                            }
                        }
                        visited.insert(varDecl);                        
                    }

                    break;
                }
            }                
        }
    }
    
    if (DeclStmt* declStmt = dyn_cast<DeclStmt>(st)) {
        PRINT_DEBUG_MESSAGE("found a DeclStmt");
        if (declStmt->isSingleDecl()) {
            const Decl* decl = declStmt->getSingleDecl();
            if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {                    
                unsigned definitionBegin = sm->getFileOffset(sm->getFileLoc(varDecl->getSourceRange().getBegin()));
                if (statement->stmtElement.contains("definitions")) {
                    for (unsigned int i = 0; i < statement->stmtElement["definitions"].size(); i++) {
                        if (definitionBegin == statement->stmtElement["definitions"][i]["range_begin"]) {
                            statement->definitions.push_back(varDecl);                                
                            currDefinitions.insert(varDecl);
                            currWrites.insert(varDecl);
                            break;
                        }                                
                    }                
                }      

                if (statement->stmtElement.contains("decls")) {
                    for (unsigned int i = 0; i < statement->stmtElement["decls"].size(); i++) {
                        if (definitionBegin == statement->stmtElement["decls"][i]["range_begin"]) {
                            statement->decls.push_back(varDecl);
                            if (varDecl->hasLocalStorage()) {
                                currDefinitions.insert(varDecl);
                            }
                        }
                    }                
                }                                        
            }
        }
        else {
            DeclStmt::const_decl_iterator it;
            for (it = declStmt->decl_begin(); it != declStmt->decl_end(); it++) {
                const Decl* decl = *it;

                if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {
                    unsigned definitionBegin = sm->getFileOffset(sm->getFileLoc(varDecl->getSourceRange().getBegin()));
                    if (statement->stmtElement.contains("definitions")) {
                        for (unsigned int i = 0; i < statement->stmtElement["definitions"].size(); i++) {
                            if (definitionBegin == statement->stmtElement["definitions"][i]["range_begin"]) {
                                currDefinitions.insert(varDecl);
                                statement->definitions.push_back(varDecl);
                                break;                                    
                            }
                        }                
                    }       

                    if (statement->stmtElement.contains("decls")) {
                        for (unsigned int i = 0; i < statement->stmtElement["decls"].size(); i++) {
                            if (definitionBegin == statement->stmtElement["decls"][i]["range_begin"]) {
                                statement->decls.push_back(varDecl);
                                if (varDecl->hasLocalStorage()) {
                                    currDefinitions.insert(varDecl);
                                }
                            }
                        }                
                    }                                        
                }                       
            }             
        }
    }
    
    if (const CallExpr* call = dyn_cast<CallExpr>(st)) {
        PRINT_DEBUG_MESSAGE("found a CallExpr");
        if (statement->stmtElement.contains("calls")) {
            for (unsigned int i = 0; i < statement->stmtElement["calls"].size(); i++) {
                if (locBegin == statement->stmtElement["calls"][i]["range_begin"]) {
                    statement->calls.push_back(call);
                }
            }                
        }  
    }

    if (const FloatingLiteral* literal = dyn_cast<FloatingLiteral>(st)) {
        statement->consts.push_back(literal);
    }

    return true;
}

bool ExpandPrecisionVisitor::Block_ProcessStmtSecondPass(Stmt* st) {
    SourceRange locRange = st->getSourceRange();
    unsigned locBegin = sm->getFileOffset(sm->getFileLoc(locRange.getBegin()));
    //unsigned locEnd = sm->getFileOffset(sm->getFileLoc(locRange.getEnd()));

    unsigned int regionIndex = currentRegion / 2;
    bool beginConverted = currentRegion % 2;

    if (regionIndex >= mergedRegions[traversingFunc].size())
        return true;

    SourceLocation regionLoc = beginConverted ? mergedRegions[traversingFunc][regionIndex].range.getEnd() : mergedRegions[traversingFunc][regionIndex].range.getBegin();
    unsigned regionLocOffset = sm->getFileOffset(sm->getFileLoc(regionLoc));
    // end of block processing: move one character after
    if (beginConverted && mergedRegions[traversingFunc][regionIndex].endOfBlock) {
        regionLocOffset++;
    }

    if (currentRange == RANGE_ENTRY || currentRange == RANGE_EXITENTRY) {
        currentRange = RANGE_IN;
    }
    else if (currentRange == RANGE_EXIT) {
        currentRange = RANGE_OUT;
    }

    if ((beginConverted && regionLocOffset <= locBegin) || (!beginConverted && regionLocOffset == locBegin)) {
        if (beginConverted) {
            currentRange = RANGE_EXIT;
        }
        else {
            currentRange = RANGE_ENTRY;
        }
        currentRegion++;

        // special case where two regions are packed next to each other.
        if (currentRange == RANGE_EXIT) {
            regionIndex = currentRegion / 2;
            bool beginConverted = currentRegion % 2;

            SourceLocation regionLoc = beginConverted ? mergedRegions[traversingFunc][regionIndex].range.getEnd() : mergedRegions[traversingFunc][regionIndex].range.getBegin();
            unsigned regionLocOffset = sm->getFileOffset(sm->getFileLoc(regionLoc));

            if (regionLocOffset == locBegin) {
                currentRange = RANGE_EXITENTRY;
                currentRegion++;
            }
        }
    }

    if (currentRange == RANGE_EXIT || currentRange == RANGE_EXITENTRY) {
        reviseVars = NULL;
        replaceVars = NULL;
        castVars = NULL;
        extReference = NULL;
        writeOnlyVars = NULL;

        if (currentRange == RANGE_EXIT) return true;
    } 
    else if (currentRange == RANGE_OUT) {
        return true;
    }
    
    if (currentRange == RANGE_ENTRY || currentRange == RANGE_EXITENTRY) {
        regionIndex = currentRegion / 2;

        reviseVars = &mergedRegionsInStmt[traversingFunc][regionIndex].reviseVars;
        replaceVars = &mergedRegionsInStmt[traversingFunc][regionIndex].replaceVars;
        castVars = &mergedRegionsInStmt[traversingFunc][regionIndex].castVars;
        extReference = &mergedRegionsInStmt[traversingFunc][regionIndex].extReference;
        writeOnlyVars = &mergedRegionsInStmt[traversingFunc][regionIndex].writeOnlyVars;
    }

    if (IsComplexStatement(st))
        return true;    

    // update regionIndex
    regionIndex = currentRegion / 2;

    // begin tracking writes / L-values
    const Expr* lhsPtr = NULL;
    anchorPointForRHS = FindLHSRHS(st, anchorPointForRHS, &lhsPtr, astContext);    

    // if L-value is floating point related but are arrays/pointers, we should
    // cast it back
    if (lhsPtr) {
        FloatingPointTypeInfo info = DissectFloatingPointType(lhsPtr->getType(), true);
        if (info.isSimpleFPType()) {
            bool insertTypeCast = false;
            // if LHS is a single variable reference, check if it is in write only list
            if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(lhsPtr))  {
                const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
                if (varDecl) {
                    set<const VarDecl*>::const_iterator it = writeOnlyVars->find(varDecl);
                    if (it != writeOnlyVars->end()) {
                        // REWRITE type cast
                        insertTypeCast = true;                      
                    }                       
                }
            }
            else if (const MemberExpr* memberExpr = dyn_cast<MemberExpr>(lhsPtr)) {
                // TODO in case it is not a vector member access, but for now we assume there is no need to cast
                Expr* base = memberExpr->getBase();
                FloatingPointTypeInfo info = DissectFloatingPointType(base->getType(), true);
                if (info.isSimpleFPType() && !info.isVector) {
                    // REWRITE type cast
                    insertTypeCast = true;
                }
            }
            else {
                // REWRITE type cast
                insertTypeCast = true;
            }
            // TODO: possible vector initializer
            if (useExtendedPrecision) {
                if (insertTypeCast) {
                    SourceLocation beginLoc = GetExpandedLocation(anchorPointForRHS->getBeginLoc(), true);
                    SourceLocation endLoc = GetExpandedLocation(anchorPointForRHS->getEndLoc(), false);
                    rewriter.InsertText(beginLoc, castBackFuncName + "(");
                    rewriter.InsertTextAfterToken(endLoc, ")");
                }
            }
        }
    }
    // end tracking writes / L-values

    // find the variable in this statement
    if (DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
        const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
        if (varDecl) {
            PRINT_DEBUG_MESSAGE("check varDecl: " << varDecl->getName().str());
            FloatingPointTypeInfo info = DissectFloatingPointType(declRefExpr->getType(), true);
            bool isSimpleType = info.isSimpleFPType();
            set<const VarDecl*>::const_iterator it = replaceVars->find(varDecl);
            if (it != replaceVars->end()) {
                string newName = GetTransformedVarName(varDecl->getName().str(), regionIndex);
                // REWRITE use casted var name
                rewriter.ReplaceText(declRefExpr->getExprLoc(), varDecl->getName().str().length(), newName);
            }
            map<const VarDecl*, std::string>::const_iterator it2 = reviseVars->find(varDecl);
            if (isSimpleType && it2 != reviseVars->end()) {
                string newName = GetTransformedVarName(varDecl->getName().str(), regionIndex);
                // REWRITE use casted var name
                rewriter.ReplaceText(declRefExpr->getExprLoc(), varDecl->getName().str().length(), newName);                
            }
            it = castVars->find(varDecl);
            if (it != castVars->end()) {
                const auto& parents = astContext->getParents(*declRefExpr);
                if (!parents.empty()) {
                    const Stmt* parentStmt = parents[0].get<Stmt>();
                    if (parentStmt) {
                        // first check if this castVars is directly used as function arguments. if they are,
                        // ignore it, for CallExpr to process
                        const UnaryOperator* uop;
                        if (const CallExpr* callExpr = dyn_cast<CallExpr>(parentStmt)) {

                        }
                        else if (IsInsideStmt<UnaryExprOrTypeTraitExpr>(st, astContext)) {

                        }
                        // check if they are used as part of addressing or sizeof(). If they are, ignore it.
                        else if ((uop = dyn_cast<UnaryOperator>(parentStmt)) && uop->getOpcode() == UO_AddrOf){

                        }
                        else {
                            const Expr* lhs = NULL;
                            FindLHSRHS((Stmt*)parentStmt, NULL, &lhs, astContext);
                            // if this castVars also an LHS, ignore this specific reference
                            if (lhs == NULL) {
                                // if it is a pointer/array, it means it is an external pointer/array being read here.
                                // so ignore
                                if (isSimpleType) {    
                                    string newTypeString = GetRaisedTypeString(varDecl);
                                    // REWRITE type cast
                                    if (info.isVector == 0) {
                                        rewriter.InsertText(declRefExpr->getBeginLoc(), extendPrecisionFuncName + "(");
                                        rewriter.InsertTextAfterToken(declRefExpr->getEndLoc(), ")");      
                                    }
                                    else {
                                        rewriter.InsertText(declRefExpr->getBeginLoc(), "make_vec" + to_string(info.isVector + 1) + "(" + extendPrecisionTypeName + ", ");
                                        rewriter.InsertTextAfterToken(declRefExpr->getEndLoc(), ")");
                                    }                  
                                }
                            }
                        }
                    }
                }
            }
            // this is an external array or pointer
            it = extReference->find(varDecl);
            if (it != extReference->end()) {
                //bool isPointer = false;
                //if (varDecl->getTypeSourceInfo()) {
                    //TypeLoc typeLoc = varDecl->getTypeSourceInfo()->getTypeLoc();
                    //FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);
                    //isPointer = info.isPointer;
                //}

                // L value (writes)
                if (anchorPointForRHS) {

                }
                // R value (reads)
                else {
                    string newTypeString = GetRaisedTypeString(varDecl);
                    const Expr* currentExpr = declRefExpr;
                    // REWRITE type cast for array/pointer
                    while (true) {
                        const auto& parents = astContext->getParents(*currentExpr);
                        if (parents.empty())
                            break;
                        currentExpr = parents[0].get<Expr>();
                        if (!currentExpr)
                            break;
                        if (isa<CallExpr>(currentExpr) && !isa<CXXOperatorCallExpr>(currentExpr))
                            break;
                        FloatingPointTypeInfo info = DissectFloatingPointType(currentExpr->getType(), true);
                        if (info.isSimpleFPType()) {
                            PrintStatement("modify: ", currentExpr, astContext);
                            string prefix = extendPrecisionFuncName + "(";
                            rewriter.InsertText(currentExpr->getBeginLoc(), prefix);
                            rewriter.InsertTextAfterToken(currentExpr->getEndLoc(), ")");
                            break;
                        }                      
                    }
                }
            }
        }
    }

    if (DeclStmt* declStmt = dyn_cast<DeclStmt>(st)) {
        vector<const VarDecl*> declForTypeCheck;
        if (declStmt->isSingleDecl()) {
            const Decl* decl = declStmt->getSingleDecl();
            if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {
                map<const VarDecl*, std::string>::const_iterator it = reviseVars->find(varDecl);
                if (it != reviseVars->end()) {
                    declForTypeCheck.push_back(varDecl);
                    PRINT_DEBUG_MESSAGE("check DeclStmt varDecl: " << varDecl->getName().str());
                }
                set<const VarDecl*>::const_iterator it2 = writeOnlyVars->find(varDecl);
                if (it2 != writeOnlyVars->end()) {
                    // REWRITE cast back for initializers
                    // TODO: possible vector initializer
                    if (useExtendedPrecision) {
                        if (const Expr* initializer = varDecl->getInit()) {
                            if (!isa<CXXConstructExpr>(initializer)) {
                                rewriter.InsertText(initializer->getBeginLoc(), castBackFuncName + "(");
                                rewriter.InsertTextAfterToken(initializer->getEndLoc(), ")");
                            }
                        }                
                    }
                }                                                                  
            }
        }
        else {
            DeclStmt::const_decl_iterator it;
            for (it = declStmt->decl_begin(); it != declStmt->decl_end(); it++) {
                const Decl* decl = *it;

                if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {
                    map<const VarDecl*, std::string>::const_iterator it = reviseVars->find(varDecl);
                    if (it != reviseVars->end()) {
                        declForTypeCheck.push_back(varDecl);
                        PRINT_DEBUG_MESSAGE("check DeclStmt varDecl: " << varDecl->getName().str());
                    }                                        
                }                       
            }             
        }
        
        if (declForTypeCheck.size() > 0 && declForTypeCheck[0]->getTypeSourceInfo()) {
            string newTypeString = GetRaisedTypeString(declForTypeCheck[0]);
            if (newTypeString != "") {
                FloatingPointTypeInfo info = DissectFloatingPointType(declForTypeCheck[0]->getType(), true);
                if (info.isSimpleFPType()) {
                    // REWRITE declaration type
                    rewriter.ReplaceText(declForTypeCheck[0]->getTypeSourceInfo()->getTypeLoc().getSourceRange(), newTypeString);

                    // REWRITE initializer type case
                    for (const VarDecl* varDecl : declForTypeCheck) {
                        // REWRITE revise var name
                        string newVarName = GetTransformedVarName(varDecl->getName().str(), regionIndex);
                        rewriter.ReplaceText(varDecl->getLocation(), varDecl->getName().str().length(), newVarName);
                        
                        if (const Expr* initializer = varDecl->getInit()) {
                            if (!isa<CXXConstructExpr>(initializer) && !isa<FloatingLiteral>(initializer)) {
                                rewriter.InsertText(initializer->getBeginLoc(), extendPrecisionFuncName + "(");
                                rewriter.InsertTextAfterToken(initializer->getEndLoc(), ")");
                            }
                        }
                    }                        
                }              
            }
        }    
    }

    if (const CallExpr* call = dyn_cast<CallExpr>(st)) {
        bool processed = ProcessMathFunctions(call);

        // if the function is not replaced, we should cast the arguments to double.
        if (!processed) {
            for (unsigned int i = 0; i < call->getNumArgs(); i++) {
                const ParmVarDecl* param = NULL;
                const FunctionDecl* funcDecl = call->getDirectCallee();
                if (funcDecl) {
                    QualType qualType = call->getArg(i)->getType();
                    //QualType origQualType = qualType;
                    if (funcDecl->getNumParams() == call->getNumArgs()) {
                        param = funcDecl->getParamDecl(i);
                        qualType = param->getOriginalType();
                    }
                    FloatingPointTypeInfo info = DissectFloatingPointType(qualType, true);
                    // TODO: possible vector initializer
                    if (info.isSimpleFPType()) {
                        if (useExtendedPrecision) {
                            rewriter.InsertText(call->getArg(i)->getBeginLoc(), castBackFuncName + "(");
                            rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");
                        }
                        else if (info.isVector) {
                            // REWRITE value conversion
                            string dimension = info.isVector ? to_string(info.isVector + 1) : "";
                            rewriter.InsertText(call->getArg(i)->getBeginLoc(), "ConvertValue" + dimension + "(" + qualType.getAsString() + ", " + extendPrecisionTypeName + dimension + ", ");
                            rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");                                
                        }
                    }
                    #if AUTO_ARRAY_TRANSFORM                    
                    else if ((info.isFPPointer() || info.isFPArray()) && origQualType.getTypePtrOrNull()) {
                        // REWRITE reference conversion
                        // TODO dimension
                        if (const ImplicitCastExpr* impCast = dyn_cast<ImplicitCastExpr>(call->getArg(i))) {
                            if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(impCast->getSubExprAsWritten())) {
                                const clang::ArrayType* arrayTypeObj = dyn_cast<clang::ArrayType>(declRefExpr->getDecl()->getType().getTypePtrOrNull());
                                if (arrayTypeObj) {
                                    rewriter.InsertText(call->getArg(i)->getBeginLoc(), "ConvertArray(" + 
                                        arrayTypeObj->getElementType().getAsString() + ", " + extendPrecisionTypeName + ", ");
                                    rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");
                                }
                            }
                        }
                    }
                    #endif
                    else if (info.isFloatingPoint && info.isReference && qualType.getTypePtrOrNull()) {
                        // REWRITE reference conversion
                        if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(call->getArg(i))) {
                            // get the referenced variable. if it is castVars, ignore
                            const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
                            if (varDecl) {
                                PRINT_DEBUG_MESSAGE("check varDecl: " << varDecl->getName().str());
                                set<const VarDecl*>::const_iterator it = castVars->find(varDecl);
                                if (it == castVars->end()) {
                                    string dimension = info.isVector ? to_string(info.isVector + 1) : "";
                                    rewriter.InsertText(call->getArg(i)->getBeginLoc(), "ConvertRef" + dimension + "(" + qualType.getTypePtrOrNull()->getPointeeType().getAsString() + ", " 
                                        + extendPrecisionTypeName + dimension + ", ");
                                    rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");
                                }
                            }
                        }
                    }
                }                
            }
        }
    }

    if (const CXXFunctionalCastExpr* cast = dyn_cast<CXXFunctionalCastExpr>(st)) {
        FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);            
        if (info.isSimpleFPType()) {
            string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
            rewriter.ReplaceText(cast->getTypeInfoAsWritten()->getTypeLoc().getSourceRange(), newTypeString);
        }
    }

    if (const CStyleCastExpr* cast = dyn_cast<CStyleCastExpr>(st)) {
        FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);            
        if (info.isSimpleFPType() && !(useExtendedPrecision && currentFuncType != FUNC_TYPE_HOST)) {
            string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
            rewriter.ReplaceText(cast->getTypeInfoAsWritten()->getTypeLoc().getSourceRange(), newTypeString);
        }        
    }

    if (isa<ReturnStmt>(st) ||
        isa<ContinueStmt>(st) ||
        isa<BreakStmt>(st)
        ) {
        // in region return statement: wrap it in braces then insert end blocks.
        Region_InsertExitBlockBeforeBreak(traversingFunc, regionIndex, st);
    }

    if (const UnaryOperator* uop = dyn_cast<UnaryOperator>(st)) {
        if (uop->getOpcode() == UO_AddrOf) {
            FloatingPointTypeInfo info = DissectFloatingPointType(uop->getSubExpr()->getType(), true);
            //string origTypeName = cast->getTypeAsWritten().getAsString();     
            // TODO: temporary, will come back for better type conversion       
            if (info.isSimpleFPType()) {  
                if (info.isVector && !useExtendedPrecision) {
                    // REWRITE reference conversion
                    string dimension = to_string(info.isVector + 1);
                    rewriter.InsertText(uop->getBeginLoc(), "RefConverter" + dimension + "<" + extendPrecisionTypeName + dimension + ", " + uop->getSubExpr()->getType().getAsString() + ">(");
                    rewriter.InsertTextAfterToken(uop->getEndLoc(), ").ptr()");                                
                }                    
                /*else {
                    rewriter.InsertText(uop->getBeginLoc(), "RefConverter<" + extendPrecisionTypeName + ", " + uop->getSubExpr()->getType().getAsString() + ">(");
                    rewriter.InsertTextAfterToken(uop->getEndLoc(), ").ptr()");        
                }*/
            }
        }
    }

    if (const FloatingLiteral* literal = dyn_cast<FloatingLiteral>(st)) {
        std::string fpText;
        raw_string_ostream wrap(fpText);
        literal->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
        if (!useExtendedPrecision && (ends_with(fpText, "F") || ends_with(fpText, "f"))) {
            fpText.erase(fpText.length() - 1, 1);
            rewriter.ReplaceText(literal->getSourceRange(), fpText);
        }
    }    

    return true;
}

bool ExpandPrecisionVisitor::Func_ProcessStmt(Stmt* st) {
    // begin tracking writes / L-values
    const Expr* lhsPtr = NULL;
    anchorPointForRHS = FindLHSRHS(st, anchorPointForRHS, &lhsPtr, astContext);    

    // if L-value is floating point related but are arrays/pointers, we should
    // cast it back
    if (lhsPtr) {
        FloatingPointTypeInfo info = DissectFloatingPointType(lhsPtr->getType(), true);
        if (info.isSimpleFPType() && !isa<DeclRefExpr>(lhsPtr)) {
            // REWRITE type cast
            // TODO: possible vector initializer
            if (useExtendedPrecision) {
                SourceLocation beginLoc = GetExpandedLocation(anchorPointForRHS->getBeginLoc(), true);
                SourceLocation endLoc = GetExpandedLocation(anchorPointForRHS->getEndLoc(), false);
                rewriter.InsertText(beginLoc, castBackFuncName + "(");
                rewriter.InsertTextAfterToken(endLoc, ")");
            }
        }
    }
    // end tracking writes / L-values

    // array subscript
    /*if (anchorPointForRHS == NULL) {
        if (const ArraySubscriptExpr* subscriptExpr = dyn_cast<ArraySubscriptExpr>(st)) {
            // find parent, if it is &, ignore
            const auto& parents = astContext->getParents(*subscriptExpr);
            if (!parents.empty()) {
                const UnaryOperator* parentExpr = parents[0].get<UnaryOperator>();
                if (!parentExpr || parentExpr->getOpcode() != UO_AddrOf) {
                    FloatingPointTypeInfo info = DissectFloatingPointType(subscriptExpr->getType(), true); 
                    if (info.isSimpleFPType()) {
                        SourceLocation beginLoc = GetExpandedLocation(subscriptExpr->getBeginLoc(), true);
                        SourceLocation endLoc = GetExpandedLocation(subscriptExpr->getEndLoc(), false);
                        if (info.isVector && !info.isReference) {
                            string dimension = std::to_string(info.isVector + 1);
                            rewriter.InsertText(beginLoc, "ConvertValue" + dimension + "(" + extendPrecisionTypeName + dimension + ", " + 
                                subscriptExpr->getType().getAsString() + ", ");
                            rewriter.InsertTextAfterToken(endLoc, ")");                       
                        }
                        else {
                            rewriter.InsertText(beginLoc, extendPrecisionFuncName + "(");
                            rewriter.InsertTextAfterToken(endLoc, ")");   
                        }         
                    }                    
                }
            }
        }
    }*/
    if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
        const ValueDecl* valueDecl = declRefExpr->getDecl();
        if (valueDecl && valueDecl->getIdentifier() && argReplacement.find(valueDecl->getName().str()) != argReplacement.end()) {
            string newName = GetTransformedVarName(valueDecl->getName().str());
            rewriter.ReplaceText(declRefExpr->getExprLoc(), valueDecl->getName().str().length(), newName);
            PRINT_DEBUG_MESSAGE("\tnew name: " << newName);
        }
    }
    else if (const CallExpr* call = dyn_cast<CallExpr>(st)) {
        bool processed = ProcessMathFunctions(call);

        // if the function is not replaced, we should cast the arguments to double.
        if (!processed) {
            bool convertToOriginal = false;
            // Do not process printf functions unless extended precision is used
            //string funcName = call->getDirectCallee()->getNameInfo().getAsString();
            //if (funcName == "printf" && !useExtendedPrecision) {
            //    PRINT_DEBUG_MESSAGE("printf in lower precision. should process them in a different way");
            //    convertToOriginal = true;
            //}

            for (unsigned int i = 0; i < call->getNumArgs(); i++) {
                const ParmVarDecl* param = NULL;
                const FunctionDecl* funcDecl = call->getDirectCallee();
                if (funcDecl) {
                    QualType qualType = call->getArg(i)->getType();
                    //QualType origQualType = qualType;
                    if (funcDecl->getNumParams() == call->getNumArgs()) {
                        param = funcDecl->getParamDecl(i);
                        qualType = param->getOriginalType();
                    }
                    FloatingPointTypeInfo info = DissectFloatingPointType(qualType, true);
                    // TODO: possible vector initializer
                    if (info.isSimpleFPType()) {
                        if (useExtendedPrecision || convertToOriginal) {
                            rewriter.InsertText(call->getArg(i)->getBeginLoc(), castBackFuncName + "(");
                            rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");
                        }
                        else if (info.isVector) {
                            // REWRITE reference conversion
                            string dimension = info.isVector ? to_string(info.isVector + 1) : "";
                            rewriter.InsertText(call->getArg(i)->getBeginLoc(), "RefConverter" + dimension + "<" + extendPrecisionTypeName + dimension + ", " + qualType.getAsString() + ">(");
                            rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ").ref()");                                
                        }
                    }
                    #if AUTO_ARRAY_TRANSFORM                    
                    else if ((info.isFPPointer() || info.isFPArray()) && origQualType.getTypePtrOrNull()) {
                        // REWRITE reference conversion
                        // TODO dimension
                        if (const ImplicitCastExpr* impCast = dyn_cast<ImplicitCastExpr>(call->getArg(i))) {
                            if (const DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(impCast->getSubExprAsWritten())) {
                                const clang::ArrayType* arrayTypeObj = dyn_cast<clang::ArrayType>(declRefExpr->getDecl()->getType().getTypePtrOrNull());
                                if (arrayTypeObj) {
                                    rewriter.InsertText(call->getArg(i)->getBeginLoc(), "ConvertArray(" + 
                                        arrayTypeObj->getElementType().getAsString() + ", " + extendPrecisionTypeName + ", ");
                                    rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ")");
                                }
                            }
                        }
                    }
                    #endif
                    else if (info.isFloatingPoint && info.isReference && qualType.getTypePtrOrNull()) {
                        // REWRITE reference conversion
                        string dimension = info.isVector ? to_string(info.isVector + 1) : "";
                        rewriter.InsertText(call->getArg(i)->getBeginLoc(), "RefConverter" + dimension + "<" + extendPrecisionTypeName + dimension + ", " + 
                            qualType.getTypePtrOrNull()->getPointeeType().getAsString() + ">(");
                        rewriter.InsertTextAfterToken(call->getArg(i)->getEndLoc(), ").ref()");
                    }
                }
            }
        }
    }
    else if (const DeclStmt* declStmt = dyn_cast<DeclStmt>(st)) {
        vector<const VarDecl*> declForTypeCheck;
        if (declStmt->isSingleDecl()) {
            const Decl* decl = declStmt->getSingleDecl();
            if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {
                declForTypeCheck.push_back(varDecl);
                PRINT_DEBUG_MESSAGE("check DeclStmt varDecl: " << varDecl->getName().str());                                                             
            }
        }
        else {
            DeclStmt::const_decl_iterator it;
            for (it = declStmt->decl_begin(); it != declStmt->decl_end(); it++) {
                const Decl* decl = *it;

                if (const VarDecl* varDecl = dyn_cast<VarDecl>(decl)) {
                    declForTypeCheck.push_back(varDecl);
                    PRINT_DEBUG_MESSAGE("check DeclStmt varDecl: " << varDecl->getName().str());                            
                }                       
            }             
        }
        
        if (declForTypeCheck.size() > 0 && declForTypeCheck[0]->getTypeSourceInfo()) {
            string newTypeString = GetRaisedTypeString(declForTypeCheck[0]);
            PRINT_DEBUG_MESSAGE("new type string: " << newTypeString);
            if (newTypeString != "") {
                FloatingPointTypeInfo info = DissectFloatingPointType(declForTypeCheck[0]->getType(), true);
                if (info.isSimpleFPType()) {
                    string newTypeName = GetTransformedTypeName(extendPrecisionTypeName, info.isVector);
                    rewriter.ReplaceText(declForTypeCheck[0]->getTypeSourceInfo()->getTypeLoc().getSourceRange(), newTypeName);         
                }
                #if AUTO_ARRAY_TRANSFORM
                else if (info.isFPArray()) {
                    string newTypeName = GetTransformedTypeName(extendPrecisionTypeName, info.isVector);
                    const clang::ArrayTypeLoc arrayTypeLoc = declForTypeCheck[0]->getTypeSourceInfo()->getTypeLoc().getAs<clang::ArrayTypeLoc>();
                    if (!arrayTypeLoc.isNull()) {
                        const clang::TypeLoc elementLoc = arrayTypeLoc.getElementLoc();
                        rewriter.ReplaceText(elementLoc.getSourceRange(), newTypeName);                        
                    }
                }
                #endif
            }
        }  
    }
    else if (const CXXFunctionalCastExpr* cast = dyn_cast<CXXFunctionalCastExpr>(st)) {
        FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);
        //string origTypeName = cast->getTypeAsWritten().getAsString();            
        if (info.isSimpleFPType()) {                
            string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
            string convertString = "ValueConverter" + (info.isVector == 0 ? "" : to_string(info.isVector + 1)) + "<";
            string convertString2 = ", " + newTypeString + ">";
            rewriter.InsertText(cast->getTypeInfoAsWritten()->getTypeLoc().getBeginLoc(), convertString, true, true);
            rewriter.InsertTextAfterToken(cast->getTypeInfoAsWritten()->getTypeLoc().getEndLoc(), convertString2);
        }
    }
    else if (const CStyleCastExpr* cast = dyn_cast<CStyleCastExpr>(st)) {
        FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);
        //string origTypeName = cast->getTypeAsWritten().getAsString();            
        if (info.isSimpleFPType() && !(useExtendedPrecision && currentFuncType != FUNC_TYPE_HOST)) {                
            string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
            rewriter.ReplaceText(cast->getTypeInfoAsWritten()->getTypeLoc().getSourceRange(), newTypeString);
        }
    }
    else if (isa<ReturnStmt>(st) ||
        isa<ContinueStmt>(st) ||
        isa<BreakStmt>(st)
        ) {
        // in region return statement: wrap it in braces then insert end blocks.
        Func_InsertExitBlockBeforeBreak(st);
    }
    else if (const UnaryOperator* uop = dyn_cast<UnaryOperator>(st)) {
        if (uop->getOpcode() == UO_AddrOf) {
            FloatingPointTypeInfo info = DissectFloatingPointType(uop->getSubExpr()->getType(), true);
            //string origTypeName = cast->getTypeAsWritten().getAsString();            
            // TODO: temporary, will come back for better type conversion       
            if (info.isSimpleFPType()) {  
                if (info.isVector && !useExtendedPrecision) {  
                    // REWRITE reference conversion
                    string dimension = to_string(info.isVector + 1);
                    rewriter.InsertText(uop->getBeginLoc(), "RefConverter" + dimension + "<" + extendPrecisionTypeName + dimension + ", " + uop->getSubExpr()->getType().getAsString() + ">(");
                    rewriter.InsertTextAfterToken(uop->getEndLoc(), ").ptr()");                                
                }                    
                /*else {
                    rewriter.InsertText(uop->getBeginLoc(), "RefConverter<" + extendPrecisionTypeName + ", " + uop->getSubExpr()->getType().getAsString() + ">(");
                    rewriter.InsertTextAfterToken(uop->getEndLoc(), ").ptr()");        
                }*/
            }
        }
    }
    else if (const FloatingLiteral* literal = dyn_cast<FloatingLiteral>(st)) {
        std::string fpText;
        raw_string_ostream wrap(fpText);
        literal->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
        if (!useExtendedPrecision && (ends_with(fpText, "F") || ends_with(fpText, "f"))) {
            fpText.erase(fpText.length() - 1, 1);
            rewriter.ReplaceText(literal->getSourceRange(), fpText);
        }
    }    

    return true;    
}

bool ExpandPrecisionVisitor::SubExpression_ProcessStmt(Stmt *st) {
    bool printResultsMode = currentMode == TRANSFORM_PRINT_ONLY;
    SourceRange locRange = st->getSourceRange();
    unsigned locBegin = sm->getFileOffset(sm->getFileLoc(locRange.getBegin()));
    unsigned locEnd = sm->getFileOffset(sm->getFileLoc(locRange.getEnd()));    
    if (currentStatementIndex >= subExpressionIsolationInfos.size())
        return true;

    if (currentSubExprIndex < 0) {
        unsigned subExBegin = sm->getFileOffset(sm->getFileLoc(subExpressionIsolationInfos[currentStatementIndex].range.getBegin()));
        unsigned subExEnd = sm->getFileOffset(sm->getFileLoc(subExpressionIsolationInfos[currentStatementIndex].range.getEnd()));
        if (locBegin == subExBegin && locEnd == subExEnd) {
            currentSubExprIndex = 0;
        }
        else {
            return true;
        }
    }
    else {
        currentSubExprIndex++;
        if (currentSubExprIndex >= subExpressionIsolationInfos[currentStatementIndex].subExpressionTree.size() ) {
            currentSubExprIndex = -1;
            currentStatementIndex++;

            if (currentStatementIndex >= subExpressionIsolationInfos.size())
                return true;

            unsigned subExBegin = sm->getFileOffset(sm->getFileLoc(subExpressionIsolationInfos[currentStatementIndex].range.getBegin()));
            unsigned subExEnd = sm->getFileOffset(sm->getFileLoc(subExpressionIsolationInfos[currentStatementIndex].range.getEnd()));

            if (locBegin == subExBegin && locEnd == subExEnd) {
                currentSubExprIndex = 0;
            }
            else {
                return true;
            }
        }
    }

    if (printResultsMode && resFile.is_open() && 
        std::find(subExpressionIsolationInfos[currentStatementIndex].currentSubs.begin(),
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end(),
            currentSubExprIndex) != subExpressionIsolationInfos[currentStatementIndex].currentSubs.end()) {
        PrintStatementToFile("\toffending subexpression: ", st, astContext, resFile);
        return true;
    }

    subExpressionIsolationInfos[currentStatementIndex].subExpressions[currentSubExprIndex] = st;
    bool isLeaf = std::find(subExpressionIsolationInfos[currentStatementIndex].subExpressionTree.begin(),
        subExpressionIsolationInfos[currentStatementIndex].subExpressionTree.end(), currentSubExprIndex) == 
        subExpressionIsolationInfos[currentStatementIndex].subExpressionTree.end();

    // trace back to ancestors to see if this needs 
    int traceindex = currentSubExprIndex;
    bool includedInTransform = false;
    bool isLValue = false;
    bool isAddrOf = false;
    bool isIncludedTop = false;
    PRINT_DEBUG_MESSAGE("trace index " << traceindex);
    while (true) {
        if (std::find(subExpressionIsolationInfos[currentStatementIndex].currentSubs.begin(),
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end(), traceindex) != 
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end()) {
            includedInTransform = true;
            PRINT_DEBUG_MESSAGE("\tincluded in transform");

            if (traceindex == currentSubExprIndex) {
                PRINT_DEBUG_MESSAGE("\ttop in inclusion tree");
                isIncludedTop = true;
            }
        }
        
        int parent = subExpressionIsolationInfos[currentStatementIndex].subExpressionTree[traceindex];
        if (parent < 0) {
            break;
        }
        PRINT_DEBUG_MESSAGE("\tparent index " << parent);
        Stmt* traceStmt = subExpressionIsolationInfos[currentStatementIndex].subExpressions[traceindex];
        Stmt* parentStmt = subExpressionIsolationInfos[currentStatementIndex].subExpressions[parent];

        const Expr* lhs;
        const Expr* rhs;
        FindCompoundAssignment(parentStmt, &lhs, &rhs);
        if (!lhs || !rhs) {
            FindRegularAssignment(parentStmt, &lhs, &rhs);
        }

        if (const UnaryOperator* uop = dyn_cast<UnaryOperator>(parentStmt)) {
            if (uop->getOpcode() == UO_AddrOf) {
                isAddrOf = true;
                PRINT_DEBUG_MESSAGE("\tisAddrOf");
            }
        } 

        if (lhs && rhs && !isLValue) {
            isLValue = dyn_cast<Stmt>(lhs) == traceStmt;
            PRINT_DEBUG_MESSAGE("\tisLValue " << (isLValue ? "Yes" : "No"));
        }

        traceindex = parent;
    }

    if (currentSubExprIndex == 0) {
        Stmt* traceStmt = subExpressionIsolationInfos[currentStatementIndex].subExpressions[currentSubExprIndex];
        const Expr* lhs;
        const Expr* rhs;
        FindCompoundAssignment(traceStmt, &lhs, &rhs);
        if (!lhs || !rhs) {
            FindRegularAssignment(traceStmt, &lhs, &rhs);
        }            
        if (lhs && rhs && ((std::find(subExpressionIsolationInfos[currentStatementIndex].currentSubs.begin(),
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end(), 0) != 
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end())
            || (std::find(subExpressionIsolationInfos[currentStatementIndex].currentSubs.begin(),
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end(), 2) != 
            subExpressionIsolationInfos[currentStatementIndex].currentSubs.end()))) {
            PRINT_DEBUG_MESSAGE("an assignment: insert conversion before and after");     
            std::string lhsText;
            raw_string_ostream wrap(lhsText);
            lhs->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));

            FloatingPointTypeInfo info;
            string typeText = GetRaisedTypeString(lhs->getType(), &info);
            if (info.isSimpleFPType()) {
                string nameText = "__tmp_" + to_string(currentStatementIndex);
                                 
                string beforeText = typeText + " __tmp_" + to_string(currentStatementIndex) + " = " + lhsText + ";";
                string afterText = ";" + lhsText + " = __tmp_" + to_string(currentStatementIndex) + ";";
                rewriter.ReplaceText(lhs->getSourceRange(), beforeText + nameText);   
                //rewriter.InsertText(st->getBeginLoc(), beforeText);
                SourceLocation semiLoc = findSemiAfterLocation(st->getEndLoc(), *astContext, false);
                rewriter.InsertTextAfterToken(semiLoc, afterText);
            
            }
        }
        return true;
    }

    // add enhance precision to leaf nodes
    if (!isLValue && !isAddrOf && includedInTransform) {
        if (isLeaf) {
            PRINT_DEBUG_MESSAGE("not an LValue/AddrOf, included in transform, leaf node");

            // leaf node, included in transform, not an LValue, go!
            if (DeclRefExpr* declRefExpr = dyn_cast<DeclRefExpr>(st)) {
                const VarDecl* varDecl = dyn_cast<VarDecl>(declRefExpr->getDecl());
                if (varDecl && varDecl->getIdentifier()) {
                    FloatingPointTypeInfo info;
                    string typeText = GetRaisedTypeString(varDecl, &info);
                    if (info.isSimpleFPType() && (info.isVector == 0)) {
                        string preText = "(" + typeText + ")(";
                        rewriter.InsertText(st->getBeginLoc(), preText);
                        rewriter.InsertTextAfterToken(st->getEndLoc(), ")");
                    }
                }
            }
            else if (const FloatingLiteral* literal = dyn_cast<FloatingLiteral>(st)) {
                std::string fpText;
                raw_string_ostream wrap(fpText);
                literal->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
                if (!useExtendedPrecision && (ends_with(fpText, "F") || ends_with(fpText, "f"))) {
                    fpText.erase(fpText.length() - 1, 1);
                    rewriter.ReplaceText(literal->getSourceRange(), fpText);
                }
            }   
        }
        else {
            PRINT_DEBUG_MESSAGE("not an LValue/AddrOf, included in transform, non leaf node");

            if (const CStyleCastExpr* cast = dyn_cast<CStyleCastExpr>(st)) {
                FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);            
                if (info.isSimpleFPType() && !(useExtendedPrecision && currentFuncType != FUNC_TYPE_HOST)) {
                    string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
                    rewriter.ReplaceText(cast->getTypeInfoAsWritten()->getTypeLoc().getSourceRange(), newTypeString);
                }        
            }   

            if (const CXXFunctionalCastExpr* cast = dyn_cast<CXXFunctionalCastExpr>(st)) {
                FloatingPointTypeInfo info = DissectFloatingPointType(cast->getTypeAsWritten(), true);            
                if (info.isSimpleFPType()) {
                    string newTypeString = extendPrecisionTypeName + (info.isVector == 0 ? "" : to_string(info.isVector + 1));
                    rewriter.ReplaceText(cast->getTypeInfoAsWritten()->getTypeLoc().getSourceRange(), newTypeString);
                }
            }

            if (const MemberExpr* member = dyn_cast<MemberExpr>(st)) {
                Expr* base = member->getBase();
                FloatingPointTypeInfo info = DissectFloatingPointType(base->getType(), true);
                if (info.isSimpleFPType() && info.isVector) {
                    string typeText = extendPrecisionTypeName;
                    string preText = "(" + typeText + ")(";
                    rewriter.InsertText(st->getBeginLoc(), preText);
                    rewriter.InsertTextAfterToken(st->getEndLoc(), ")");
                }
            }                     
        }     
    }    

    // process math functions
    if (includedInTransform) {
        PRINT_DEBUG_MESSAGE("callexpr");
        if (DeclRefExpr* call = dyn_cast<DeclRefExpr>(st)) {
            ProcessMathFunctions(call, isIncludedTop);
        }
    }

    if (isIncludedTop) {
        PRINT_DEBUG_MESSAGE("top subexpression, perform conversion to original");
        if (BinaryOperator* binaryOp = dyn_cast<BinaryOperator>(st)) {
            
        }
        else if (UnaryOperator* unaryOp = dyn_cast<UnaryOperator>(st)) {

        }
    }

    // add conversions back to original in top node that is in enhanced precision

    return true;
}

bool ExpandPrecisionVisitor::VisitStmt(Stmt *st) {
    if (traversingFunc == "")
        return true;

    if (isa<CXXDefaultArgExpr>(st)) {
        return true;
    }

    if (currentPass)
        PrintStatement("Statement: ", st, astContext);

    if (currentPass == 0) {
        // CUDA kernel call check
        if (isa<CUDAKernelCallExpr>(st)) {
            SourceLocation semiLoc = findSemiAfterLocation(st->getEndLoc(), *astContext, false);
            rewriter.InsertTextAfterToken(semiLoc, codeAfterKernelCall);
        }
    }
    else if (currentMode == TRANSFORM_FUNCTION || currentMode == TRANSFORM_SIGNATURE) {
        PRINT_DEBUG_MESSAGE("func process");
        return Func_ProcessStmt(st);
    }
    else if (subExpressionIsolation) {
        PRINT_DEBUG_MESSAGE("subex process");
        return SubExpression_ProcessStmt(st);
    }
    else {
        PRINT_DEBUG_MESSAGE("block process");
        if (currentPass == 1)
            return Block_ProcessStmtFirstPass(st);
        if (currentPass == 2)
            return Block_ProcessStmtSecondPass(st);
    }

    return true;
}

string ExpandPrecisionVisitor::Func_InsertEntryExitBlocks(SourceLocation loc, SourceLocation endLoc, ParmVarDecl* param, FloatingPointTypeInfo argTypeInfo) {
    string argName = param->getName().str();
    string buildText, endBuildText;
    string newTypeName = GetRaisedTypeString(param, NULL);
    // REWRITE insert type conversion before start of function
    if (argTypeInfo.isVector > 0) {
        buildText = "define_vec" + to_string(argTypeInfo.isVector + 1) + "(" + newTypeName + ", " +
            argName + "_d, " + argName + ");\n";
        endBuildText = "init_vec" + to_string(argTypeInfo.isVector + 1) + "(" + argName + ", " + argName + "_d);\n";
    }
    else {
        buildText = extendPrecisionTypeName + " " + argName + "_d = " + extendPrecisionFuncName + "(" + argName + ");\n";
        endBuildText = argName + " = " + castBackFuncName + "(" + argName + "_d);\n";
    }
    rewriter.InsertTextAfterToken(loc, buildText);
    if (!argTypeInfo.isConst)
        rewriter.InsertText(endLoc, endBuildText, true, true);
    return argName;
}

void ExpandPrecisionVisitor::Func_InsertExitBlockBeforeBreak(Stmt* st) {
    if (argReplacement.empty())
        return;

    string endBuildText;
    // always assume the return/break/continue statement is a single statement. wrap a set of braces around it
    rewriter.InsertText(st->getBeginLoc(), "{\n", true, true);
    SourceLocation semiLoc = findSemiAfterLocation(st->getEndLoc(), *astContext, false);
    rewriter.InsertTextAfterToken(semiLoc, "}");

    for (auto& item : argReplacement) {
        const string& argName = item.first;
        const FloatingPointTypeInfo& argTypeInfo = item.second;
        if (!argTypeInfo.isConst) {
            // REWRITE insert type conversion before start of function
            if (argTypeInfo.isVector > 0) {
                endBuildText = "init_vec" + to_string(argTypeInfo.isVector + 1) + "(" + argName + ", " + argName + "_d);\n";
            }
            else {
                endBuildText = argName + " = " + castBackFuncName + "(" + argName + "_d);\n";
            }
            rewriter.InsertText(st->getBeginLoc(), endBuildText, true, true);
        }
    }
}

void ExpandPrecisionVisitor::Region_InsertExitBlockBeforeBreak(string traversingFunc, unsigned int regionIndex, Stmt* st) {
    auto& region = mergedRegionsInStmt[traversingFunc][regionIndex];
    unsigned returnLocOffset = sm->getFileOffset(sm->getFileLoc(st->getBeginLoc()));

    // always assume the return/break/continue statement is a single statement. wrap a set of braces around it
    rewriter.InsertText(st->getBeginLoc(), "{\n", true, true);
    SourceLocation semiLoc = findSemiAfterLocation(st->getEndLoc(), *astContext, false);
    rewriter.InsertTextAfterToken(semiLoc, "}");

    for (const VarDecl* item : region.replaceVars) {
        FloatingPointTypeInfo info;
        string newTypeString = GetRaisedTypeString(item, &info);
        if (newTypeString != "" && !info.isConst) {
            if (info.isVector == 0) {
                string newDeclText = item->getName().str() + " = " + castBackFuncName + "(" + GetTransformedVarName(item->getName().str(), regionIndex) + ");\n";
                rewriter.InsertText(st->getBeginLoc(), newDeclText, true, true);     
            }
            else {
                string newDeclText = "init_vec" + to_string(info.isVector + 1) + "(" + item->getName().str() + ", " + GetTransformedVarName(item->getName().str(), regionIndex) + ");\n";
                rewriter.InsertText(st->getBeginLoc(), newDeclText, true, true);     
            } 
        }    
    }

    // declare 
    for (auto const& item : region.reviseVars) {
        FloatingPointTypeInfo info;
        // for revise variable, some of them declares later than the exit point.
        unsigned varDeclOffset = sm->getFileOffset(sm->getFileLoc(item.first->getBeginLoc()));
        if (returnLocOffset < varDeclOffset)
            continue;
        string newTypeString = GetRaisedTypeString(item.first, &info);
        string origTypeName = item.first->getType().getAsString();
        if (newTypeString != "" && info.isSimpleFPType() && !info.isConst) {
            if (info.isVector == 0) {
                string newDeclText = origTypeName + " " + item.second + " = " + castBackFuncName + "(" +  GetTransformedVarName(item.second, regionIndex) + ");\n";
                rewriter.InsertText(st->getBeginLoc(), newDeclText, true, true);  
            }
            else {
                string origTypeString = GetTransformedTypeName(castBackFuncName, info.isVector);
                string newDeclText = "define_vec" + to_string(info.isVector + 1) + "(" + origTypeString + ", " + item.second + ", " + GetTransformedVarName(item.second, regionIndex) + ");\n";
                rewriter.InsertText(st->getBeginLoc(), newDeclText, true, true);
            }
        }        
    }     
}

void ExpandPrecisionVisitor::Region_InsertEntryExitBlocks() {    
    for (auto& funcRegions : mergedRegionsInStmt) {
        // get function body
        PRINT_DEBUG_MESSAGE("insert in function " << funcRegions.first);
        const CompoundStmt *fBody = dyn_cast<CompoundStmt>(funcStartingPoints[funcRegions.first]);
        SourceLocation startingPoint = sm->getFileLoc(fBody->body_front()->getBeginLoc());
        currentFuncType = funcTypes[funcRegions.first];

        SetupTransformIdentifiers(currentFuncType == FUNC_TYPE_HOST);

        set<const VarDecl*> lastRegionVars;

        for (unsigned int i = 0; i < funcRegions.second.size(); i++) {                       
            auto& region = funcRegions.second[i];
            auto& regionInRange = mergedRegions[funcRegions.first][i];
            SourceLocation beginLoc = region.begin->getBeginLoc();            
            SourceLocation endLoc;
            if (regionInRange.compoundBlock) {
                if (const CompoundStmt* compoundStmt = dyn_cast<CompoundStmt>(region.begin)) {
                    beginLoc = compoundStmt->body_front()->getBeginLoc();
                    endLoc = compoundStmt->body_back()->getEndLoc();
                    SourceLocation semiLoc = findSemiAfterLocation(endLoc, *astContext, false);
                    if (semiLoc.isValid())
                        endLoc = semiLoc;
                }
                PRINT_DEBUG_MESSAGE("compound block");
            }
            else if (regionInRange.endOfBlock) {
                SourceLocation semiLoc = findSemiAfterLocation(regionInRange.range.getEnd(), *astContext, false);
                if (semiLoc.isValid())
                    endLoc = semiLoc;
                else
                    endLoc = regionInRange.range.getEnd();
            }
            else {
                endLoc = region.end->getBeginLoc();
            }
            PRINT_DEBUG_MESSAGE("check entry exit for region " << i << ", compound block " << (regionInRange.compoundBlock ? 1 : 0) 
                << ", end of block " << regionInRange.endOfBlock); 
            rewriter.InsertText(beginLoc, "/* begin region " + to_string(i) + " */", false, true);              
            for (const VarDecl* item : region.replaceVars) {
                PRINT_DEBUG_MESSAGE("\tchecking var " << item->getName().str());
                FloatingPointTypeInfo info;
                string newTypeString = GetRaisedTypeString(item, &info);
                if (newTypeString != "") {
                    if (info.isVector == 0) {
                        string newDeclText = newTypeString + " " + GetTransformedVarName(item->getName().str(), i) + ";\n";
                        rewriter.InsertText(startingPoint, newDeclText, true, true);
                        // REWRITE insert type conversion before/after block
                        if (region.regionType == REGION_TYPE_ADJACENT_START && lastRegionVars.find(item) != lastRegionVars.end()) {
                            newDeclText = GetTransformedVarName(item->getName().str(), i) + " = " + GetTransformedVarName(item->getName().str(), i - 1) + ";\n";
                        }
                        else {
                            newDeclText = GetTransformedVarName(item->getName().str(), i) + " = " + extendPrecisionFuncName + "(" + item->getName().str() + ");\n";
                        }
                        rewriter.InsertText(beginLoc, newDeclText, true, true);  

                        if (!info.isConst) {
                            newDeclText = item->getName().str() + " = " + castBackFuncName + "(" + GetTransformedVarName(item->getName().str(), i) + ");\n";
                            if (regionInRange.endOfBlock)
                                rewriter.InsertTextAfterToken(endLoc, newDeclText); 
                            else
                                rewriter.InsertText(endLoc, newDeclText, true, true);   
                        }   
                    }
                    else {
                        // REWRITE insert type conversion before/after block
                        string newDeclText = newTypeString + " " + GetTransformedVarName(item->getName().str(), i) + ";\n";
                        rewriter.InsertText(startingPoint, newDeclText, true, true);
                        if (region.regionType == REGION_TYPE_ADJACENT_START && lastRegionVars.find(item) != lastRegionVars.end()) {
                            newDeclText = "init_vec" + to_string(info.isVector + 1) + "(" + GetTransformedVarName(item->getName().str(), i) + ", " + GetTransformedVarName(item->getName().str(), i - 1) + ");\n";
                        }
                        else {
                            newDeclText = "init_vec" + to_string(info.isVector + 1) + "(" + GetTransformedVarName(item->getName().str(), i) + ", " + item->getName().str() + ");\n";
                        }                        
                        rewriter.InsertText(beginLoc, newDeclText, true, true);  

                        if (!info.isConst) {
                            newDeclText = "init_vec" + to_string(info.isVector + 1) + "(" + item->getName().str() + ", " + GetTransformedVarName(item->getName().str(), i) + ");\n";
                            if (regionInRange.endOfBlock)
                                rewriter.InsertTextAfterToken(endLoc, newDeclText); 
                            else
                                rewriter.InsertText(endLoc, newDeclText, true, true);      
                        }
                    } 

                    if (region.regionType == REGION_TYPE_ADJACENT_EXIT) {
                        lastRegionVars.insert(item);
                    }
                }    
            }

            // declare
            if (regionInRange.endOfBlock != END_OF_BLOCK_NORMAL) {
                for (auto const& item : region.reviseVars) {
                    FloatingPointTypeInfo info;
                    string newTypeString = GetRaisedTypeString(item.first, &info);
                    string origTypeName = item.first->getType().getAsString();
                    PRINT_DEBUG_MESSAGE("\tchecking var " << item.second);

                    SourceRange range = FindVarDeclScope(item.first, astContext);
                    SourceRange endRange(endLoc);

                    PRINT_DEBUG_MESSAGE("var range:");
                    PrintSourceRange(range, astContext);
                    PRINT_DEBUG_MESSAGE("end range:");
                    PrintSourceRange(endRange, astContext);

                    if (range.fullyContains(endRange) && newTypeString != "" && info.isSimpleFPType() && !info.isConst) {
                        string newDeclText;
                        if (info.isVector == 0) {
                            newDeclText = origTypeName + " " + item.second + " = " + castBackFuncName + "(" + GetTransformedVarName(item.second, i) + ");\n";                            
                        }
                        else {
                            string origTypeString = GetTransformedTypeName(castBackFuncName, info.isVector);
                            newDeclText = "define_vec" + to_string(info.isVector + 1) + "(" + origTypeString + ", " + item.second + ", " + GetTransformedVarName(item.second, i) + ");\n";
                        }
                        if (regionInRange.endOfBlock == END_OF_BLOCK_FALSE)                        
                            rewriter.InsertText(endLoc, newDeclText, true, true);
                        else
                            rewriter.InsertTextAfterToken(endLoc, newDeclText);   
                    }    

                    if (region.regionType == REGION_TYPE_ADJACENT_EXIT) {
                        lastRegionVars.insert(item.first);
                    }                    
                }
            }

            if (region.regionType != REGION_TYPE_ADJACENT_EXIT) {
                lastRegionVars.clear();
            }

            if (regionInRange.endOfBlock)
                rewriter.InsertTextAfterToken(endLoc, "/* end region " + to_string(i) + " */");
            else
                rewriter.InsertText(endLoc, "/* end region " + to_string(i) + " */", true, true);  
        }
    }
}

void ExpandPrecisionVisitor::EndOfFuncProcessing() {
    if (currentRange == RANGE_IN || currentRange == RANGE_ENTRY || currentRange == RANGE_EXITENTRY) {
        unsigned int regionIndex = currentRegion / 2;
        mergedRegionsInStmt[traversingFunc][regionIndex].end = NULL;        

        if (currentPass == 1) {
            PRINT_DEBUG_MESSAGE("exit region " << regionIndex << " at the end of function");
            currentRegion++;

            // debug print all variable in list
            PRINT_DEBUG_MESSAGE("in region " << (currentRegion / 2 - 1));
            PRINT_DEBUG_MESSAGE("external array/pointer: " << extReference->size());
            for (const VarDecl* varDecl : *extReference) {
                PRINT_DEBUG_MESSAGE("\t" << varDecl->getName());
            }

            // collect variables to be cast
            for (const VarDecl* item : currReads) {
                if (visited.find(item) == visited.end()) {
                    castVars->insert(item);
                }
            }

            PRINT_DEBUG_MESSAGE("variables to cast: " << castVars->size());
            for (const VarDecl* item : *castVars) {
                PRINT_DEBUG_MESSAGE("\t" << item->getName());
            }

            // collect variables as write only
            for (const VarDecl* item : currWrites) {
                if (visited.find(item) == visited.end()) {
                    bool woSet = false;
                    if (item->getTypeSourceInfo()) {
                        TypeLoc typeLoc = item->getTypeSourceInfo()->getTypeLoc();
                        FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);

                        if (!info.isSimpleFPType()) {
                            writeOnlyVars->insert(item);
                            woSet = true;
                        }
                    }
                    if (!woSet) {
                        if (currDefinitions.find(item) == currDefinitions.end()) {
                            replaceVars->insert(item);
                        }
                        else
                            reviseVars->insert(std::pair<const VarDecl*, std::string>(item, item->getName().str()));
                    }                    
                }            
            }

            PRINT_DEBUG_MESSAGE("variables to cast back: " << writeOnlyVars->size());
            for (const VarDecl* item : *writeOnlyVars) {
                PRINT_DEBUG_MESSAGE("\t" << item->getName());
            }     

            PRINT_DEBUG_MESSAGE("variables to revise: " << reviseVars->size());
            for (auto const& item : *reviseVars) {
                PRINT_DEBUG_MESSAGE("\t" << item.second);
            }
            PRINT_DEBUG_MESSAGE("variables to replace: " << replaceVars->size());
            for (const VarDecl* item : *replaceVars) {
                PRINT_DEBUG_MESSAGE("\t" << item->getName());
            }

            currReads.clear();
            currWrites.clear();
            currDefinitions.clear();
            visited.clear();

            reviseVars = NULL;
            replaceVars = NULL;
            castVars = NULL;
            extReference = NULL;
            writeOnlyVars = NULL;
        }
        else if (currentPass == 2) {

        }
    }

    currentRange = RANGE_OUT;
}

bool ExpandPrecisionVisitor::VisitFunctionDecl(FunctionDecl* func) {
    if (!func->doesThisDeclarationHaveABody())
        return true;

    string funcName = func->getNameInfo().getName().getAsString();

    // find main() location, to insert initialization code.
    if (currentPass == 1 && funcName == "main") {
        hasMain = true;
        CompoundStmt* body = dyn_cast<CompoundStmt>(func->getBody());
        mainBodyLocation = (body && !body->body_empty()) ? body->body_front()->getBeginLoc() : body->getEndLoc();
    }

    auto loc1 = func->getLocation();
    // check against a list of excluded directories
    for (size_t i = 0; i < sizeof(sSystemIncludeDirectories) / sizeof(const char*); i++) {
        string fileName = astContext->getSourceManager().getFilename(loc1).str();
        if (fileName == "" || fileName.find(sSystemIncludeDirectories[i]) != std::string::npos)
            return true;
    }

    // the remaining functions are checked for CUDA kernel calls and insert error checks
    if (currentPass == 0) {
        if (currentMode != TRANSFORM_SIGNATURE) {
            traversingFunc = funcName;
            TraverseStmt(func->getBody());    
            EndOfFuncProcessing();
            traversingFunc = "";
        }
        return true;
    }

    // only transform functions in the even smaller list
    if (transformFuncs.find(funcName) == transformFuncs.end())
        return true;

    PRINT_DEBUG_MESSAGE("func name to transform: " << funcName << " mode: " << currentMode);

    // check function signature (host/global/device) and determine the types to use for replacement
    SourceRange declRange = clang::SourceRange(func->getSourceRange().getBegin(), func->getBody()->getSourceRange().getBegin());
    StringRef declStr = Lexer::getSourceText(clang::CharSourceRange::getTokenRange(declRange), astContext->getSourceManager(), astContext->getLangOpts());
    PRINT_DEBUG_MESSAGE("Function Decl: " << declStr.substr(0, declStr.size() - 2).str());
    if (declStr.find("__global__") != std::string::npos)
        currentFuncType = FUNC_TYPE_GLOBAL;
    else if (declStr.find("__device__") != std::string::npos)
        currentFuncType = FUNC_TYPE_DEVICE;
    else
        currentFuncType = FUNC_TYPE_HOST;

    funcTypes[funcName] = currentFuncType;

    SetupTransformIdentifiers(currentFuncType == FUNC_TYPE_HOST);

    PRINT_DEBUG_MESSAGE("use type name: " << extendPrecisionTypeName);

    if (currentMode == TRANSFORM_FUNCTION || currentMode == TRANSFORM_SIGNATURE) {
        argReplacement.clear();
        // check argument list
        for (ParmVarDecl* param : func->parameters()) {
            PRINT_DEBUG_MESSAGE("argument: " << param->getName().str() << " type: " << param->getOriginalType().getAsString());
            FloatingPointTypeInfo argTypeInfo = DissectFloatingPointType(param->getOriginalType(), false);
            if (argTypeInfo.isFloatingPoint) {
                if (argTypeInfo.isSimpleFPType() || argTypeInfo.isReference) {
                    // plain old 
                    CompoundStmt* stmt = (CompoundStmt*)func->getBody();
                    if (stmt->size() == 0)
                        return true;
                    string argName = param->getName().str();

                    // add it to the list of reference we will change
                    argReplacement[argName] = argTypeInfo;
                }

                if (argTypeInfo.isSimpleFPType() && currentMode == TRANSFORM_SIGNATURE) {
                    std::string typeString = GetRaisedTypeString(param, NULL);
                    TypeLoc typeLoc = param->getTypeSourceInfo()->getTypeLoc();
                    rewriter.ReplaceText(typeLoc.getSourceRange(), typeString);
                }
            }
        }

        if (currentMode == TRANSFORM_SIGNATURE)
            return true;
    }

    currentRange = RANGE_OUT;
    currentRegion = 0;
    currentStatementIndex = 0;
    currentSubExprIndex = -1;

    // skip all isolated statements that do not belong to this function
    for (currentStatementIndex = 0; currentStatementIndex < subExpressionIsolationInfos.size(); currentStatementIndex++) {
        if (subExpressionIsolationInfos[currentStatementIndex].funcName == funcName)
            break;
    }
    PRINT_DEBUG_MESSAGE("start current statement index: " << currentStatementIndex);

    traversingFunc = funcName;
    funcStartingPoints[traversingFunc] = func->getBody();
    TraverseStmt(func->getBody());    
    EndOfFuncProcessing();
    traversingFunc = "";

    if (currentMode == TRANSFORM_FUNCTION) {
        argReplacement.clear();
        // check argument list
        CompoundStmt* stmt = (CompoundStmt*)func->getBody();
        if (stmt->size() == 0)
            return true;
        rewriter.InsertText(stmt->getBeginLoc(), "/* converted function */", true, true);
        for (ParmVarDecl* param : func->parameters()) {
            PRINT_DEBUG_MESSAGE("argument: " << param->getName().str() << " type: " << param->getOriginalType().getAsString());
            FloatingPointTypeInfo argTypeInfo = DissectFloatingPointType(param->getOriginalType(), false);
            if (argTypeInfo.isFloatingPoint) {
                if (argTypeInfo.isSimpleFPType() || argTypeInfo.isReference) {
                    string argName = Func_InsertEntryExitBlocks(stmt->getBeginLoc(), stmt->getEndLoc(), param, argTypeInfo);
                }
            }
        }
    }

    return true;
}

void ExpandPrecisionASTConsumer::HandleTranslationUnit(ASTContext &Context) {
    FileID id = rewriter.getSourceMgr().getMainFileID();
    std::string basefilename = basename(rewriter.getSourceMgr().getFilename(rewriter.getSourceMgr().getLocForStartOfFile(id)).str());
    string filename = "./workspace/" + basefilename;
    visitor->SetupFileStart();

    PRINT_DEBUG_MESSAGE("base filename: " << basefilename);

    // sub expression isolation: initialization
    ifstream subExpressionIsolationFile("./subex_isolation.out");
    if (subExpressionIsolationFile.is_open()) {
        subExpressionIsolation = true;
        string s;
        while (subExpressionIsolationFile >> s) {
            SubExpressionIsolationInfo info;
            info.range = SourceRange();
            size_t pos = s.find(";");
            info.funcName = s.substr(0, pos);
            PRINT_DEBUG_MESSAGE("funcname: " << info.funcName);
            s.erase(0, pos + 1);

            pos = s.find(";");
            string temp = s.substr(0, pos);
            s.erase(0, pos + 1);
            while ((pos = temp.find(",")) != std::string::npos) {
                info.stmtIndices.push_back(stoi(temp.substr(0, pos)));
                temp.erase(0, pos + 1);
            }
            info.stmtIndices.push_back(stoi(temp));

            pos = s.find(";");
            temp = s.substr(0, pos);
            s.erase(0, pos + 1);
            while ((pos = temp.find(",")) != std::string::npos) {
                info.currentSubs.push_back(stoi(temp.substr(0, pos)));
                PRINT_DEBUG_MESSAGE("current subs: " << stoi(temp.substr(0, pos)));
                temp.erase(0, pos + 1);
            }
            info.currentSubs.push_back(stoi(temp));
            PRINT_DEBUG_MESSAGE("current subs: " << stoi(temp));

            pos = s.find(";");
            temp = s.substr(0, pos);
            s.erase(0, pos + 1);
            while ((pos = temp.find(",")) != std::string::npos) {
                info.subExpressionTree.push_back(stoi(temp.substr(0, pos)));
                temp.erase(0, pos + 1);                
            }
            info.subExpressionTree.push_back(stoi(temp));

            // last part
            while ((pos = s.find(",")) != std::string::npos) {
                info.subExTypes.push_back(stoi(s.substr(0, pos)));
                s.erase(0, pos + 1);
            }
            info.subExTypes.push_back(stoi(s));
            info.subExpressions.resize(info.subExpressionTree.size(), NULL);

            subExpressionIsolationInfos.push_back(info);
        }
        subExpressionIsolationFile.close();
    }

    if (printResultsMode) {
        visitor->openResultFile();
    }

    // read transform list file
    std::ifstream tlFile;
    tlFile.open("./workspace/transform_list.txt");
    if (tlFile.is_open()) {
        string s;
        tlFile >> s;
        if (s.find("func") != std::string::npos || s.find("signature") != std::string::npos) {
            if (printResultsMode)
                visitor->SetMode(TRANSFORM_PRINT_ONLY);            
            else if (s.find("func") != std::string::npos)
                visitor->SetMode(TRANSFORM_FUNCTION);
            else
                visitor->SetMode(TRANSFORM_SIGNATURE);
            while (tlFile >> s) {
                size_t pos = s.find(":");
                if (pos != std::string::npos) {
                    string funcfilename = s.substr(0, pos);
                    if (funcfilename == basefilename) {
                        string jsonName = basename(s.substr(pos));
                        size_t extPos = jsonName.find(".json");
                        string funcName = jsonName.substr(0, extPos);

                        json j;
                        j["placeholder"] = true;
                        visitor->AppendFunc(funcName, j);
                    }
                }
            }
        }
        else {
            if (printResultsMode)
                visitor->SetMode(TRANSFORM_PRINT_ONLY);
            else if (s.find("block") != std::string::npos)
                visitor->SetMode(TRANSFORM_BLOCKS);

            while (tlFile >> s) {            
                size_t pos = s.find(":");
                if (pos != std::string::npos) {
                    string funcfilename = s.substr(0, pos);
                    if (funcfilename == basefilename) {
                        string jsonName = s.substr(pos + 1);
                        size_t extPos = basename(jsonName).find(".json");
                        string funcName = basename(jsonName).substr(0, extPos);

                        json j;
                        std::ifstream jsonFile;
                        jsonFile.open(jsonName);

                        if (jsonFile.is_open()) {
                            jsonFile >> j;
                            visitor->AppendFunc(funcName, j);
                            jsonFile.close();
                        }
                    }
                }
            }
        }
        tlFile.close();
    }

    if (printResultsMode) {
        if (subExpressionIsolation) {
            // to print the reference names for subexpression isolation, traverse one last time
            visitor->ResetTraversal(1);
            visitor->TraverseDecl(Context.getTranslationUnitDecl());
        }
        visitor->closeResultFile();
        return;
    }

    visitor->ResetTraversal(0);
    visitor->TraverseDecl(Context.getTranslationUnitDecl());

    if (visitor->numFuncToTransform() > 0) {
        // find and transform functions/code segments
        visitor->ResetTraversal(1);
        visitor->TraverseDecl(Context.getTranslationUnitDecl());

        if (visitor->GetMode() == TRANSFORM_BLOCKS && !subExpressionIsolation) {
            visitor->ResetTraversal(2);
            visitor->TraverseDecl(Context.getTranslationUnitDecl());
            visitor->Region_InsertEntryExitBlocks();
        }  

        
        if (visitor->GetMode() != TRANSFORM_SIGNATURE) {
            if (useExtendedPrecision) {
                if (pureHostFunctions) {
                    // insert macro at the beginning of the file
                    rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), transformIncludePureHost);
                }
                else {
                    // insert macro at the beginning of the file
                    rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), transformInclude);

                    // insert initialization code at the beginning of main()
                    if (visitor->HasMain()) {
                        rewriter.InsertText(visitor->GetMainLocation(), beforeInitCode);
                    }
                }
            }
            else {
                if (pureHostFunctions) {
                    // insert macro at the beginning of the file
                    rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), transformIncludePureHost);
                }
                else {
                    // insert macro at the beginning of the file
                    rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), transformInclude);
                }
            }
        } else {
            rewriter.InsertText(rewriter.getSourceMgr().getLocForStartOfFile(id), transformIncludeSignature);
        }

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
}

unique_ptr<ASTConsumer> PluginExpandPrecisionAction::CreateASTConsumer(CompilerInstance &CI, StringRef file) {
    g_mainFilename = file.str();
    g_dirName = g_mainFilename;
    size_t dotpos = g_dirName.find(".");
    if (dotpos != std::string::npos)
        g_dirName = g_dirName.replace(dotpos, 1, "_");

    // prevent running the plugin twice
    if (CI.getLangOpts().LangStd == LangStandard::Kind::lang_cuda) {
        PRINT_DEBUG_MESSAGE("CUDA language detected");
        std::string basefilename = basename(g_mainFilename);
        string markerFileName = "./plugin_run_rp_";
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

    // read setup.ini
    ifstream setupFile("./setup.ini");
    if (setupFile.is_open()) {
        string s;
        while (getline(setupFile, s)) {
            if (s.find("UseExtendedPrecision") != std::string::npos) {
                useExtendedPrecision = string_to_lower(s).find("yes") != std::string::npos;
                PRINT_DEBUG_MESSAGE("Line: UseExtendedPrecision " << useExtendedPrecision);
            }
            if (s.find("SearchInHeaders") != std::string::npos) {
                searchInHeaders = string_to_lower(s).find("yes") != std::string::npos;
                PRINT_DEBUG_MESSAGE("Line: SearchInHeaders " << searchInHeaders);
            }
            if (s.find("SearchInHostFunctions") != std::string::npos) {
                searchInHostFunctions = string_to_lower(s).find("yes") != std::string::npos;
                PRINT_DEBUG_MESSAGE("Line: SearchInHostFunctions " << searchInHostFunctions);
            }
            if (s.find("PureHostFunctions") != std::string::npos) {
                pureHostFunctions = string_to_lower(s).find("yes") != std::string::npos;
                PRINT_DEBUG_MESSAGE("Line: PureHostFunctions " << pureHostFunctions);
            }
        }
        setupFile.close();
    }

    return make_unique<ExpandPrecisionASTConsumer>(&CI, false);
}
 
bool PluginExpandPrecisionAction::ParseArgs(const CompilerInstance &CI, const vector<string> &args) {
    return true;
}

unique_ptr<ASTConsumer> PluginPrintResultsAction::CreateASTConsumer(CompilerInstance &CI, StringRef file) {
    g_mainFilename = file.str();
    g_dirName = g_mainFilename;
    size_t dotpos = g_dirName.find(".");
    if (dotpos != std::string::npos)
        g_dirName = g_dirName.replace(dotpos, 1, "_");

    // prevent running the plugin twice
    if (CI.getLangOpts().LangStd == LangStandard::Kind::lang_cuda) {
        PRINT_DEBUG_MESSAGE("CUDA language detected");
        std::string basefilename = basename(g_mainFilename);
        string markerFileName = "./plugin_run_pr_";
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

    return make_unique<ExpandPrecisionASTConsumer>(&CI, true);
}
 
bool PluginPrintResultsAction::ParseArgs(const CompilerInstance &CI, const vector<string> &args) {
    return true;
}
