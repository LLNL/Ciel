#pragma once

using namespace std;
using namespace clang;
using namespace llvm;

extern string g_mainFilename;
extern string g_dirName;
extern Rewriter rewriter;

#define TRANSFORM_FUNCTION 0
#define TRANSFORM_BLOCKS 1
#define TRANSFORM_SIGNATURE 2
#define TRANSFORM_PRINT_ONLY 3
#define TRANSFORM_SUBEXPRESSION 4

#define STATEMENT_BLOCK_PREFIX 0x80000000

#define RANGE_OUT 0
#define RANGE_ENTRY 1
#define RANGE_IN 2
#define RANGE_EXIT 3
#define RANGE_EXITENTRY 4

#define FUNC_TYPE_HOST 0
#define FUNC_TYPE_GLOBAL 1
#define FUNC_TYPE_DEVICE 2

#define REGION_TYPE_NORMAL 0
#define REGION_TYPE_ADJACENT_START 1
#define REGION_TYPE_ADJACENT_EXIT 2

struct RegionInStmt {
    int regionType;
    const Stmt* begin;
    const Stmt* end;

    set<const VarDecl*> replaceVars, castVars, extReference, writeOnlyVars;
    map<const VarDecl*, std::string> reviseVars;
};

class ExpandPrecisionVisitor : public RecursiveASTVisitor<ExpandPrecisionVisitor> {
private:
    ASTContext *astContext; // used for getting additional AST info
    SourceManager *sm;

    TypeLoc GetInnermostTypeLoc(TypeLoc loc);

    string traversingFunc = "";
    map<string, FloatingPointTypeInfo> argReplacement;

    int currentMode;
    int currentPass = 0;

    map<string, json> transformFuncs;
    map<string, vector<RegionInRange>> mergedRegions;
    SourceLocation regionStartLocation;
    bool startLocationValid = false;

    map<string, vector<RegionInStmt>> mergedRegionsInStmt;
    map<string, Stmt*> funcStartingPoints;

    map<string, int> funcTypes;
    unsigned int currentRegion = 0;
    
    SourceLocation fileStart;

    set<const VarDecl*>* extReference = NULL;
    set<const VarDecl*>* replaceVars = NULL;
    set<const VarDecl*>* castVars = NULL;
    set<const VarDecl*>* writeOnlyVars = NULL;
    map<const VarDecl*, std::string>* reviseVars = NULL;
    set<const VarDecl*> currReads, currWrites, currDefinitions, visited;
    map<string, FunctionInfo> regionInfos;
    int currentRange = RANGE_OUT;
    int currentFuncType = FUNC_TYPE_HOST;

    // if not NULL, it means still on the left hand side of an assignment statement.
    const Stmt* anchorPointForRHS = NULL;

    std::ofstream resFile;

    bool hasMain = false;
    SourceLocation mainBodyLocation;

    vector<int> statementIndices;
    unsigned int currentStatementIndex = 0;
    int currentSubExprIndex = -1;

public:
    explicit ExpandPrecisionVisitor(CompilerInstance *CI)
        : astContext(&(CI->getASTContext())) // initialize private members
    {
        rewriter.setSourceMgr(astContext->getSourceManager(),
            astContext->getLangOpts());     
        sm = &astContext->getSourceManager();
    }
 
    // traverse functions.
    virtual bool VisitStmt(Stmt *st);
    virtual bool VisitFunctionDecl(FunctionDecl* func);

    // pre traverse analysis
    void AnalyzeBlocks(json& root, BasicBlockInfo& info);
    void AnalyzeStatements(json& root, BasicBlockInfo& info);
    void FindRegionsInBlocks(json& root, BasicBlockInfo& info, vector<RegionInRange>& regions);
    void FindRegionsInStatements(json& root, BasicBlockInfo& info, vector<RegionInRange>& regions);

    bool PrintEnabledStatementsInBlocks(json& root, BasicBlockInfo& info, bool alreadyEnabled, std::ostream& outFile);
    bool PrintEnabledStatementsInStatements(json& root, BasicBlockInfo& info, bool alreadyEnabled, std::ostream& outFile);

    void AppendFunc(string func, json funcJson) { transformFuncs[func] = funcJson; SetTransformRegions(func, funcJson); }
    void SetTransformRegions(string func, json& j);
    void EndOfFuncProcessing();

    // insert temp variable definitions before and after the regions
    void Region_InsertExitBlockBeforeBreak(string traversingFunc, unsigned int regionIndex, Stmt* st);
    void Region_InsertEntryExitBlocks();

    // insert temp variable definitions before and after functions
    string Func_InsertEntryExitBlocks(SourceLocation loc, SourceLocation endLoc, ParmVarDecl* param, FloatingPointTypeInfo argTypeInfo);
    void Func_InsertExitBlockBeforeBreak(Stmt* st);

    bool ProcessMathFunctions(const CallExpr* call);
    bool ProcessMathFunctions(const DeclRefExpr* call, bool convertToOriginal);
    string FindReplaceMathFunctionName(string oldName);

    bool Func_ProcessStmt(Stmt* st);
    bool SubExpression_ProcessStmt(Stmt *st);
    bool Block_ProcessStmtFirstPass(Stmt* st);
    bool Block_ProcessStmtSecondPass(Stmt* st);

    void openResultFile();
    void closeResultFile();

public:
    void SetMode(int mode) { currentMode = mode; }
    int GetMode() { return currentMode; }
    int numFuncToTransform() { return transformFuncs.size(); }
    void SetupFileStart() { fileStart = astContext->getSourceManager().getLocForStartOfFile(astContext->getSourceManager().getMainFileID());  }
    void ResetTraversal(int pass);
    bool HasMain() { return hasMain; }
    SourceLocation GetMainLocation() { return mainBodyLocation; }
};

class ExpandPrecisionASTConsumer : public ASTConsumer {
private:
    ExpandPrecisionVisitor *visitor; // doesn't have to be private
    bool printResultsMode = false;

public:
    explicit ExpandPrecisionASTConsumer(CompilerInstance *CI, bool printResults)
        : visitor(new ExpandPrecisionVisitor(CI)) // initialize the visitor
    { 
        printResultsMode = printResults;
    }
 
    virtual void HandleTranslationUnit(ASTContext &Context);
};

class PluginExpandPrecisionAction : public PluginASTAction {
protected:
    unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI, StringRef file); 
    bool ParseArgs(const CompilerInstance &CI, const vector<string> &args);
};

class PluginPrintResultsAction : public PluginASTAction {
protected:
    unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI, StringRef file); 
    bool ParseArgs(const CompilerInstance &CI, const vector<string> &args);
};