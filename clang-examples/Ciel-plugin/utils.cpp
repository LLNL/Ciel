#include <iostream>
#include <string>
#include <unistd.h>

#include "utils.h"

extern Rewriter rewriter;

std::string extendPrecisionFuncName;
std::string castBackFuncName;
std::string extendPrecisionTypeName;
bool useExtendedPrecision = false;
bool searchInHostFunctions = true;
bool searchInHeaders = false;
bool pureHostFunctions = false;
bool subExpressionIsolation = false;

vector<SubExpressionIsolationInfo> subExpressionIsolationInfos;

FloatingPointTypeInfo DissectFloatingPointType(const clang::QualType type, bool builtIn)
{
    const clang::Type* typeObj = type.getTypePtrOrNull();
    if (typeObj == NULL)
    {
        FloatingPointTypeInfo info;
        info.isFloatingPoint = false;
        info.isVector = 0;
        info.typeObj = NULL;
        info.isArray = false;
        info.isPointer = false;
        info.isReference = false;
        info.isConst = false;
        return info;
    }
    FloatingPointTypeInfo info;
    info.isArray = false;
    info.isPointer = false;
    info.isReference = false;
    info.isConst = type.isConstQualified();
    if (const clang::ArrayType *arr = dyn_cast<clang::ArrayType>(typeObj))
    {
        PRINT_DEBUG_MESSAGE("\t\tis array type");
        info = DissectFloatingPointType(arr->getElementType(), false);
        info.isArray = true;
        return info;
    }
    else if (const clang::PointerType *ptr = dyn_cast<clang::PointerType>(typeObj))
    {
        PRINT_DEBUG_MESSAGE("\t\tis pointer type");
        info = DissectFloatingPointType(ptr->getPointeeType(), false);
        info.isPointer = true;
        return info;
    }
    else if (typeObj->isReferenceType())
    {
        PRINT_DEBUG_MESSAGE("\t\treference type");
        info = DissectFloatingPointType(typeObj->getPointeeType(), false);
        info.isReference = true;
        return info;
    }

    clang::QualType internalType = typeObj->getCanonicalTypeInternal();

    PRINT_DEBUG_MESSAGE("\t\tinnermost type " << internalType.getAsString());
    if (info.isConst) PRINT_DEBUG_MESSAGE("\t\tis const");
    if (const clang::BuiltinType *bltin = dyn_cast<clang::BuiltinType>(typeObj))
    {
        PRINT_DEBUG_MESSAGE("\t\tis builtin type, floating point: " << bltin->isFloatingPoint());
        info.isFloatingPoint = bltin->isFloatingPoint();
        info.isVector = 0;
        info.typeObj = typeObj;
        return info;
    }
    else if (typeObj->isStructureType())
    {
        PRINT_DEBUG_MESSAGE("\t\tis struct type");
        // TODO: with floating point built-in vectors and __half
        info.isFloatingPoint = false;
        info.isVector = 0;
        std::string typeStr = internalType.getAsString();
        if (typeStr == "struct __half")
        {
            info.isFloatingPoint = true;
            info.isVector = 0;
        }
        else
        {
            size_t pos = typeStr.find("struct float");
            if (pos != std::string::npos)
            {
                info.isFloatingPoint = true;
                info.isVector = typeStr[pos + strlen("struct float")] - '1';
            }
            pos = typeStr.find("struct double");
            if (pos != std::string::npos)
            {
                info.isFloatingPoint = true;
                info.isVector = typeStr[pos + strlen("struct double")] - '1';
            }
        }
        info.typeObj = typeObj;
        return info;
    }
    else
    {
        PRINT_DEBUG_MESSAGE("\t\tis another type");
        info.isFloatingPoint = false;
        info.isVector = 0;
        info.typeObj = typeObj;
        info.isArray = false;
        info.isPointer = false;
        info.isReference = false;
        info.isConst = false;
        return info;
    }
}

void PrintSourceLocation(SourceLocation loc, ASTContext *astContext)
{
    std::string text = loc.printToString(astContext->getSourceManager());
    PRINT_DEBUG_MESSAGE("location: " << text);
}

void PrintSourceRange(SourceRange range, ASTContext *astContext)
{
    std::string text1 = range.getBegin().printToString(astContext->getSourceManager());
    std::string text2 = range.getEnd().printToString(astContext->getSourceManager());
    PRINT_DEBUG_MESSAGE("\toffset: " << text1 << ", " << text2);
}

void PrintSourceRangeToFile(SourceRange range, ASTContext *astContext, ostream &out)
{
    std::string text1 = range.getBegin().printToString(astContext->getSourceManager());
    std::string text2 = range.getEnd().printToString(astContext->getSourceManager());
    out << "offending text: " << text1 << ", " << text2 << std::endl;
}

void PrintStatement(string prefix, const Stmt *st, ASTContext *astContext)
{
    std::string statementText;
    raw_string_ostream wrap(statementText);
    st->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
    PRINT_DEBUG_MESSAGE(prefix << st->getStmtClassName() << ", " << statementText);
    PrintSourceRange(st->getSourceRange(), astContext);
}

void PrintStatementToFile(string prefix, const Stmt *st, ASTContext *astContext, ostream &out)
{
    std::string statementText;
    raw_string_ostream wrap(statementText);
    st->printPretty(wrap, NULL, PrintingPolicy(astContext->getLangOpts()));
    out << prefix << st->getStmtClassName() << ", " << statementText << std::endl;
    PrintSourceRangeToFile(st->getSourceRange(), astContext, out);
}

bool IsFloatingPointDecl(const Decl *decl)
{
    if (const VarDecl *varDecl = dyn_cast<VarDecl>(decl))
    {
        PRINT_DEBUG_MESSAGE("\t\t--> VarDecl: " << varDecl->getName());
        if (varDecl->getTypeSourceInfo())
        {
            TypeLoc typeLoc = varDecl->getTypeSourceInfo()->getTypeLoc();
            FloatingPointTypeInfo info = DissectFloatingPointType(typeLoc.getType(), true);

            if (info.isFloatingPoint)
            {
                // TODO: recording reads
                return true;
            }
        }
    }
    return false;
}

std::string GetRaisedTypeString(const Decl *decl, FloatingPointTypeInfo* outInfo)
{
    std::string ret = "";
    if (const VarDecl *varDecl = dyn_cast<VarDecl>(decl))
    {
        PRINT_DEBUG_MESSAGE("\t\t--> VarDecl: " << varDecl->getName());
        if (varDecl->getTypeSourceInfo())
        {
            TypeLoc typeLoc = varDecl->getTypeSourceInfo()->getTypeLoc();
            ret = GetRaisedTypeString(typeLoc.getType(), outInfo);
        }
    }
    return ret;
}

std::string GetRaisedTypeString(QualType type, FloatingPointTypeInfo* outInfo)
{
    std::string ret = "";
    FloatingPointTypeInfo info = DissectFloatingPointType(type, true);

    if (outInfo)
        *outInfo = info;

    if (info.isFloatingPoint)
    {
        PRINT_DEBUG_MESSAGE("\t\tis floating point");
        if (true /*!info.isArray && !info.isPointer*/)
        {
            PRINT_DEBUG_MESSAGE("\t\tfloating point single fp variable");

            if (info.isVector == 0)
            {
                // replace the type of the valuedecl with double
                ret = extendPrecisionTypeName;
            }
            else
            {
                // vector variables.
                PRINT_DEBUG_MESSAGE("\t\tbuilt-in single fp vector");
                ret = GetTransformedTypeName("double", info.isVector);
            }

            if (info.isPointer)
            {
                ret += "*";
            }
        }
    }
    return ret;    
}

bool IsComplexStatement(const Stmt *st)
{
    return (isa<CompoundStmt>(st)) ||
           (isa<ForStmt>(st)) ||
           (isa<DoStmt>(st)) ||
           (isa<WhileStmt>(st)) ||
           (isa<SwitchStmt>(st)) ||
           (isa<IfStmt>(st));
}

const Stmt *FindLHSRHS(Stmt *st, const Stmt *anchor, const Expr **lhsPtr, ASTContext *astContext)
{
    if (anchor == NULL)
    {
        // find writes: use operators
        // CompoundAssignOperator (for *=, +=, etc.)
        // BinaryOperator (for =)
        // CXXOperatorCallExpr (for overloads)
        if (const BinaryOperator *binaryOp = dyn_cast<BinaryOperator>(st))
        {
            if (binaryOp->isAssignmentOp())
            {
                Expr *lhs = binaryOp->getLHS();
                Expr *rhs = binaryOp->getRHS();

                PrintStatement("\t\tLHS: ", lhs, astContext);
                PrintStatement("\t\tRHS: ", rhs, astContext);

                if (lhsPtr)
                {
                    *lhsPtr = lhs;
                }

                return rhs;
            }
        }
        else if (const CXXOperatorCallExpr *opOverload = dyn_cast<CXXOperatorCallExpr>(st))
        {
            // Cheat depending on the fact that all equal overloaded operators are packed together
            if (opOverload->isAssignmentOp())
            {
                for (unsigned int i = 0; i < opOverload->getNumArgs(); i++)
                {
                    PrintStatement("\t\targ: ", opOverload->getArg(i), astContext);
                }

                if (lhsPtr)
                {
                    *lhsPtr = opOverload->getArg(0);
                }

                return opOverload->getArg(1);
            }
        }
        return anchor;
    }
    else if (anchor == st)
        return NULL;
    else
        return anchor;
}

string basename(std::string path)
{
    return std::string(std::find_if(path.rbegin(), path.rend(), MatchPathSeparator()).base(), path.end());
}

// find compound assignment

void FindCompoundAssignment(const Stmt *st, const Expr **lhsPtr, const Expr **rhsPtr) {
    if (!st)
        return;
    const Expr *lhs = NULL;
    const Expr *rhs = NULL;
    if (const BinaryOperator *binaryOp = dyn_cast<BinaryOperator>(st))
    {
        if (binaryOp->isCompoundAssignmentOp())
        {
            lhs = binaryOp->getLHS();
            rhs = binaryOp->getRHS();
        }
    }
    else if (const CXXOperatorCallExpr *opOverload = dyn_cast<CXXOperatorCallExpr>(st))
    {
        if (opOverload->isAssignmentOp() && opOverload->getOperator() != OO_Equal)
        {
            lhs = opOverload->getArg(0);
            rhs = opOverload->getArg(1);
        }
    }

    if (lhsPtr)
        *lhsPtr = lhs;
    if (rhsPtr)
        *rhsPtr = rhs;
}

void FindRegularAssignment(const Stmt* st, const Expr** lhsPtr, const Expr** rhsPtr) {
    const Expr *lhs = NULL;
    const Expr *rhs = NULL;
    if (const BinaryOperator *binaryOp = dyn_cast<BinaryOperator>(st))
    {
        if (binaryOp->isAssignmentOp())
        {
            lhs = binaryOp->getLHS();
            rhs = binaryOp->getRHS();
        }
    }
    else if (const CXXOperatorCallExpr *opOverload = dyn_cast<CXXOperatorCallExpr>(st))
    {
        if (opOverload->isAssignmentOp() && opOverload->getOperator() == OO_Equal)
        {
            lhs = opOverload->getArg(0);
            rhs = opOverload->getArg(1);
        }
    }

    if (lhsPtr)
        *lhsPtr = lhs;
    if (rhsPtr)
        *rhsPtr = rhs;
}

/// 'Loc' is the end of a statement range. This returns the location
/// immediately after the semicolon following the statement.
/// If no semicolon is found or the location is inside a macro, the returned
/// source location will be invalid.
SourceLocation findLocationAfterSemi(SourceLocation loc,
                                     ASTContext &Ctx, bool IsDecl)
{
    SourceLocation SemiLoc = findSemiAfterLocation(loc, Ctx, IsDecl);
    if (SemiLoc.isInvalid())
        return SourceLocation();
    return SemiLoc.getLocWithOffset(1);
}

/// \arg Loc is the end of a statement range. This returns the location
/// of the semicolon following the statement.
/// If no semicolon is found or the location is inside a macro, the returned
/// source location will be invalid.
SourceLocation findSemiAfterLocation(SourceLocation loc,
                                     ASTContext &Ctx,
                                     bool IsDecl)
{
    SourceManager &SM = Ctx.getSourceManager();
    if (loc.isMacroID())
    {
        if (!Lexer::isAtEndOfMacroExpansion(loc, SM, Ctx.getLangOpts(), &loc))
            return SourceLocation();
    }
    loc = Lexer::getLocForEndOfToken(loc, /*Offset=*/0, SM, Ctx.getLangOpts());

    // Break down the source location.
    std::pair<FileID, unsigned> locInfo = SM.getDecomposedLoc(loc);

    // Try to load the file buffer.
    bool invalidTemp = false;
    StringRef file = SM.getBufferData(locInfo.first, &invalidTemp);
    if (invalidTemp)
        return SourceLocation();

    const char *tokenBegin = file.data() + locInfo.second;

    // Lex from the start of the given location.
    Lexer lexer(SM.getLocForStartOfFile(locInfo.first),
                Ctx.getLangOpts(),
                file.begin(), tokenBegin, file.end());
    Token tok;
    lexer.LexFromRawLexer(tok);
    if (tok.isNot(tok::semi))
    {
        if (!IsDecl)
            return SourceLocation();
        // Declaration may be followed with other tokens; such as an __attribute,
        // before ending with a semicolon.
        return findSemiAfterLocation(tok.getLocation(), Ctx, /*IsDecl*/ true);
    }

    return tok.getLocation();
}

SourceRange FindVarDeclScope(const VarDecl *varDecl, ASTContext *astContext)
{
    const Stmt* currentStmt = varDecl->getInit() ? dyn_cast<Stmt>(varDecl->getInit()) : NULL;
    const Decl* currentDecl = varDecl->getInit() ? NULL : varDecl;
    // if true, use stmt, else use decl
    bool useStmtOrDecl = currentStmt != NULL;
    while (true)
    {
        const auto &parents = useStmtOrDecl ? astContext->getParents(*currentStmt) : astContext->getParents(*currentDecl);

        if (parents.empty()) {
            PRINT_DEBUG_MESSAGE("empty parents");
            return SourceRange();
        }

        const Stmt *parentStmt = parents[0].get<Stmt>();
        const Decl *parentDecl = parents[0].get<Decl>();
        if (parentStmt == NULL && parentDecl == NULL) {
            PRINT_DEBUG_MESSAGE("neither stmt or decl");
            return SourceRange();
        }
        else if (parentStmt) {
            if (const CompoundStmt *compoundStmt = dyn_cast<CompoundStmt>(parentStmt))
            {
                return compoundStmt->getSourceRange();
            }            
            useStmtOrDecl = true;
        }
        else {
            useStmtOrDecl = false;
        }

        currentStmt = parentStmt;
        currentDecl = parentDecl;
    }
}

SourceLocation GetExpandedLocation(SourceLocation orig, bool isBeginOrEndLoc) {
    if (orig.isMacroID()) {
        PRINT_DEBUG_MESSAGE("\t\texpanding source range");
        CharSourceRange expandedRange = rewriter.getSourceMgr().getImmediateExpansionRange(orig);

        if (isBeginOrEndLoc)
            return expandedRange.getBegin();
        else
            return expandedRange.getEnd();
    }
    return orig;
}

SourceRange GetExpandedRange(SourceRange orig) {
    SourceLocation beginLoc = GetExpandedLocation(orig.getBegin(), true);
    SourceLocation endLoc = GetExpandedLocation(orig.getEnd(), false);
    return SourceRange(beginLoc, endLoc);
}

void SetupTransformIdentifiers(bool isHost)
 {
    if (isHost) {
        if (useExtendedPrecision) {
            extendPrecisionFuncName = host_extendPrecisionFuncName_Extended;
            castBackFuncName = host_castBackFuncName_Extended;
            extendPrecisionTypeName = host_extendPrecisionTypeName_Extended;
        }
        else {
            extendPrecisionFuncName = host_extendPrecisionFuncName_NonExtended;
            castBackFuncName = host_castBackFuncName_NonExtended;
            extendPrecisionTypeName = host_extendPrecisionTypeName_NonExtended;                
        }
    }
    else {
        if (useExtendedPrecision) {
            extendPrecisionFuncName = device_extendPrecisionFuncName_Extended;
            castBackFuncName = device_castBackFuncName_Extended;
            extendPrecisionTypeName = device_extendPrecisionTypeName_Extended;
        }
        else {
            extendPrecisionFuncName = device_extendPrecisionFuncName_NonExtended;
            castBackFuncName = device_castBackFuncName_NonExtended;
            extendPrecisionTypeName = device_extendPrecisionTypeName_NonExtended;                
        }
    }    
}