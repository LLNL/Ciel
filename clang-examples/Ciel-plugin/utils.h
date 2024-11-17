#pragma once

#include <iostream>
#include <fstream>

#include "clang/Driver/Options.h"
#include "clang/AST/Decl.h"
#include "clang/AST/AST.h"
#include "clang/AST/ASTContext.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/AST/ParentMapContext.h"
#include "clang/Frontend/ASTConsumers.h"
#include "clang/Frontend/FrontendActions.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/FrontendPluginRegistry.h"
#include "clang/Rewrite/Core/Rewriter.h"

#include "json.hpp"
#include "TransformInclude.h"

using json = nlohmann::json;

using namespace std;
using namespace clang;
using namespace llvm;

#define endline "\n"

#define VERBOSE 1
#define PRINT_DEBUG_MESSAGE(s) if (VERBOSE > 0) {errs() << s << endline; }
#define PRINT_DETAILED_DEBUG_MESSAGE(s) if (VERBOSE > 1) {errs() << s << endline; }

#define SUBEX_TYPE_OTHER 0
#define SUBEX_TYPE_FUNC 1
#define SUBEX_TYPE_VAR 2
#define SUBEX_TYPE_CALLEXPR 3
#define SUBEX_TYPE_OP 4

struct FloatingPointTypeInfo {
    bool isFloatingPoint : 1;
    unsigned int isVector : 3;
    bool isPointer : 1;
    bool isArray : 1;
    bool isReference : 1;
    bool isConst : 1;
    const clang::Type* typeObj;

    bool isSimpleFPType() {
        return isFloatingPoint && !isPointer && !isArray && !isReference;
    }
    bool isFPArray() {
        return isFloatingPoint && isArray;
    }
    bool isFPPointer() {
        return isFloatingPoint && isPointer;
    }    
};

struct FunctionInfo;
struct BasicBlockInfo;
struct LoopInfo;
struct FunctionInfo;

struct StatementTreeNode {
    int parent;
    int type;
    Stmt* stmt;
    bool isFloatType;
};

struct StatementInfo {
    const Stmt* stmt;
    SourceRange range;
    vector<const DeclRefExpr*> reads;
    vector<const DeclRefExpr*> writes;
    vector<const VarDecl*> decls;
    vector<const VarDecl*> definitions;
    vector<const CallExpr*> calls;
    vector<const Expr*> consts;
    
    // a shortcut for the function call graph
    vector<FunctionInfo*> callLinks;

    // only used during raising precision: store the json file here
    json stmtElement;  
    unsigned int enabled;  

    // only used during function analysis: store the index of the substatement here (pre-order)
    unsigned int currentIndex;
    unsigned int rhsStart;
    vector<StatementTreeNode> tree;
};

#define BLOCK_TYPE_BASIC 0          // basic
#define BLOCK_TYPE_LOOP 1           // for, while, do while
#define BLOCK_TYPE_LOOP_COMPONENT 2 // loop cond + body
#define BLOCK_TYPE_COND 3           // switch case, if
#define BLOCK_TYPE_COND_COMPONENT 4 // if/switch cond + body 
#define BLOCK_TYPE_FUNC 5           // function body

#define DISABLED 0
#define PARTIAL_ENABLED 1
#define ENABLED 2
#define INDIVIDUAL_ENABLED 3

#define END_OF_BLOCK_FALSE 0
#define END_OF_BLOCK_NORMAL 1
#define END_OF_BLOCK_FLAT_COMPOUND 2

struct CompoundStmtIter {
    const CompoundStmt* stmt;
    CompoundStmt::const_body_iterator basicBlockHead;
    CompoundStmt::const_body_iterator basicBlockTail;    
};

struct BasicBlockInfo {
    SourceRange range;
    unsigned int blockType;
    unsigned int enabled;
    // a basic block has either other blocks or statements.
    // do not allow a mixture of the two.
    vector<BasicBlockInfo> blocks;
    vector<StatementInfo> statements;
    // store the corresponding compoundStmt (or none) for easy insertion of exit blocks
    const Stmt* compoundStmt;
};

struct FunctionInfo : BasicBlockInfo {
    string name;
    // a shortcut for the function call graph
    vector<FunctionInfo*> calls;
};

struct RegionInRange {
    SourceRange range;
    // if true, range.end is not "beginning of next basic block", but "end of this block". Treated differently during insertion of exit processing code.
    int endOfBlock;
    // if true, this region consists of one whole compound statement for/while/if/switch. insertion point for entry/exit processing should be different.
    bool compoundBlock;
};

// Used by std::find_if
struct MatchPathSeparator
{
    bool operator()(char ch) const {
        return ch == '/';
    }
};

// Function to get the base name of the file provided by path
string basename(std::string path);

static const char* sSystemIncludeDirectories[] = {
    "/usr/lib/gcc",
    "/usr/local/cuda",
    "/lib/clang/",
    "/usr/include/",
    "/usr/bin/",
};

const map<std::string, std::string> mathcalls_base = {
    // TODO: expand based on CUDA Math API. Currently only for functions used in the test cases.
    {"acos", "acosl"},
    {"log", "logl"},
    {"asin", "asinl"},
    {"atan2", "atan2l"},
    {"ceil", "ceill"},
    {"exp", "expl"},
    {"pow", "powl"},
    {"atan", "atanl"},
    {"sqrt", "sqrtl"},
    {"fabs", "fabsl"},
    {"sin", "sinl"},
    {"fmod", "fmodl"},
    // from Varity
    {"sinh", "sinhl"},
    {"cosh", "coshl"},
    {"tanh", "tanhl"},
    {"log10", "log10l"},
    {"floor", "floorl"},
    {"ldexp", "ldexpl"},
    {"cos", "cosl"},
    {"fmax", "fmaxl"},
    {"fmin", "fminl"},
    {"copysign", "copysignl"}
};

FloatingPointTypeInfo DissectFloatingPointType(const clang::QualType type, bool builtIn);
bool IsFloatingPointDecl(const Decl* decl);
std::string GetRaisedTypeString(QualType type, FloatingPointTypeInfo* info = NULL);
std::string GetRaisedTypeString(const Decl* decl, FloatingPointTypeInfo* info = NULL);

void PrintStatement(string prefix, const Stmt* st, ASTContext* astContext);
void PrintStatementToFile(string prefix, const Stmt *st, ASTContext *astContext, ostream &out);
void PrintSourceLocation(SourceLocation loc, ASTContext* astContext);
void PrintSourceRange(SourceRange range, ASTContext* astContext);
void PrintSourceRangeToFile(SourceRange range, ASTContext* astContext, ostream& out);

bool IsComplexStatement(const Stmt* st);
const Stmt* FindLHSRHS(Stmt* st, const Stmt* anchor, const Expr** lhsPtr, ASTContext* astContext);
void FindCompoundAssignment(const Stmt* st, const Expr** lhsPtr, const Expr** rhsPtr);
void FindRegularAssignment(const Stmt* st, const Expr** lhsPtr, const Expr** rhsPtr);

// lifted from clang source code (TODO: licensing?)
SourceLocation findLocationAfterSemi(SourceLocation loc, ASTContext &Ctx, bool IsDecl);
SourceLocation findSemiAfterLocation(SourceLocation loc, ASTContext &Ctx, bool IsDecl);
SourceRange FindVarDeclScope(const VarDecl *varDecl, ASTContext *astContext);

template<class T>
bool IsInsideStmt(const Stmt* st, ASTContext* astContext) {
    const Stmt* currentStmt = st;
    while (true) {
        const auto& parents = astContext->getParents(*currentStmt);
        if (parents.empty()) {
            return false; // end of traversal
        }

        const Stmt* parentStmt = parents[0].get<Stmt>();
        if (parentStmt == NULL) {
            return false;
        }
        const T* typedStmt = dyn_cast<T>(parentStmt);
        if (typedStmt) {
            return true;
        }

        currentStmt = parentStmt;
    }
}

inline std::string GetTransformedTypeName(std::string typeName, unsigned int isVector) {
    string vectorSuffix = isVector == 0 ? "" : std::to_string(isVector + 1);
    string newTypeName = typeName + vectorSuffix;
    return newTypeName;
}

inline std::string GetTransformedVarName(std::string varName, int regionIndex = -1) {
    if (regionIndex == -1)
        return varName + "_d";
    else
        return varName + "_d" + to_string(regionIndex);
}

inline std::string string_to_lower(const string& str)
{
    string result = "";

    for (char ch : str) {
        result += tolower(ch);
    }

    return result;
}

inline bool ends_with(std::string const & value, std::string const & ending) {
    if (ending.size() > value.size()) return false;
    return std::equal(ending.rbegin(), ending.rend(), value.rbegin());
}

SourceLocation GetExpandedLocation(SourceLocation orig, bool isBeginOrEndLoc);
SourceRange GetExpandedRange(SourceRange orig);

struct SubExpressionIsolationInfo {
    string funcName;
    vector<int> stmtIndices;
    vector<int> currentSubs;
    vector<int> subExpressionTree;
    vector<Stmt*> subExpressions;
    vector<int> subExTypes;

    SourceRange range;
};

extern vector<SubExpressionIsolationInfo> subExpressionIsolationInfos;