#include <string>

static std::string transformInclude = R""""(

#include "/root/ciel/thirdparty/gpuprec/gqd/gqd.cu"
#include "/root/ciel/clang-examples/Ciel-plugin/ciel-base.h"
#include <cmath>

typedef long double float_80;
inline void cudaErrorCheck(cudaError_t code) {
    if (code != cudaSuccess) {
        printf("kernel error: %s\n", cudaGetErrorString(code));
    }
}

)"""";

static std::string transformIncludePureHost = R""""(

#include <stdio.h>
#include "/root/ciel/clang-examples/Ciel-plugin/ciel-base.h"
#include <cmath>

typedef long double float_80;

)"""";

static std::string transformIncludeSignature = R""""(

typedef long double float_80;

)"""";

static const std::string codeAfterKernelCall = ";{ cudaErrorCheck(cudaPeekAtLastError()); cudaDeviceSynchronize(); }";

extern bool useExtendedPrecision;
extern bool searchInHostFunctions;
extern bool searchInHeaders;
extern bool pureHostFunctions;
extern bool subExpressionIsolation;

static const std::string device_extendPrecisionFuncName_Extended = "gdd_real";
static const std::string device_castBackFuncName_Extended = "double";
static const std::string device_extendPrecisionTypeName_Extended = "gdd_real";

static const std::string host_extendPrecisionFuncName_Extended = "float_80";
static const std::string host_castBackFuncName_Extended = "double";
static const std::string host_extendPrecisionTypeName_Extended = "float_80";

static const std::string device_extendPrecisionFuncName_NonExtended = "double";
static const std::string device_castBackFuncName_NonExtended = "float";
static const std::string device_extendPrecisionTypeName_NonExtended = "double";

static const std::string host_extendPrecisionFuncName_NonExtended = "double";
static const std::string host_castBackFuncName_NonExtended = "float";
static const std::string host_extendPrecisionTypeName_NonExtended = "double";

extern std::string extendPrecisionFuncName;
extern std::string castBackFuncName;
extern std::string extendPrecisionTypeName;

static std::string beforeInitCode = R""""(

    GQDInitObj obj;
)"""";

void SetupTransformIdentifiers(bool isHost);