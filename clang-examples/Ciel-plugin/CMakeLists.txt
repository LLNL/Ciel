add_llvm_library(Ciel-plugin MODULE 
  Ciel-plugin.cpp 
  utils.cpp 
  ExpandPrecision.cpp 
  FunctionAnalysis.cpp 
  StmtRecursiveVisitor.cpp
  PLUGIN_TOOL clang)

if(LLVM_ENABLE_PLUGINS AND (WIN32 OR CYGWIN))
  target_link_libraries(Ciel-plugin PRIVATE
    clangAST
    clangBasic
    clangFrontend
    LLVMSupport
    )
endif()
