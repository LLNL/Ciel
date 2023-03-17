#include "utils.h"
#include "FunctionAnalysis.h"
#include "ExpandPrecision.h"

Rewriter rewriter;
string g_mainFilename;
string g_dirName;

FrontendPluginRegistry::Add<PluginExpandPrecisionAction>
    expandPrecisionAction("-pliner-gpu-expand-precision", "pLiner for GPU: expand FP precision pass 1");
//static FrontendPluginRegistry::Add<PluginExpandPrecisionAction>
//    expandPrecision2Action("-pliner-gpu-expand-precision-2", "pLiner for GPU: expand FP precision pass 2");
FrontendPluginRegistry::Add<PluginFunctionAnalysisAction>
    functionAnalysisAction("-pliner-gpu-function-analysis", "pLiner for GPU: analyzing functions in source code");
FrontendPluginRegistry::Add<PluginPrintResultsAction>
    printResultsAction("-pliner-gpu-print-results", "pLiner for GPU: print results");