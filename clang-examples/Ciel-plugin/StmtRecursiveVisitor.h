using namespace std;
using namespace clang;
using namespace llvm;

extern string g_mainFilename;
extern string g_dirName;
extern Rewriter rewriter;

class StmtRecursiveVisitor : public RecursiveASTVisitor<StmtRecursiveVisitor> {
private:
    //ASTContext *astContext; // used for getting additional AST info

};