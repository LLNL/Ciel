
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29) {
for (int i=0; i < var_1; ++i) {
  comp += -1.9026E34f / (-0.0f * (-1.3540E10f * var_3 * +1.0384E-35f));
comp += cosf((var_4 * atan2f((+1.1936E14f + floorf(logf(-1.2351E36f + var_5))), var_6 - sinf(logf((var_7 / +1.9267E13f * var_8 * (+1.2148E-4f - +1.8449E35f / -1.4312E-41f)))))));
for (int i=0; i < var_2; ++i) {
  float tmp_1 = -1.2494E-42f;
comp = tmp_1 - var_9 * (var_10 + sinf(var_11 * var_12 + (+1.7058E34f * (var_13 + -1.8256E-37f))));
comp += tanhf(+1.9345E-35f);
}
if (comp > atan2f(fmodf((-1.2938E34f + asinf(-0.0f)), log10f(ldexpf(var_14 - -1.9462E-1f, 2))), var_15 * var_16 + (var_17 + (-1.4608E-41f + ceilf(atanf((var_18 * (+1.1557E34f / -0.0f * (var_19 - (var_20 - var_21)))))))))) {
  comp = (+1.4328E-41f - +1.8601E-22f + (+1.5481E-36f + var_22));
comp += (-1.3630E15f * sinf(-1.5582E25f));
float tmp_2 = (var_23 * coshf((+1.2650E13f * atan2f((var_24 / (-1.2761E-43f * var_25 - var_26 - +1.6921E36f)), -1.4653E34f))));
comp += tmp_2 / var_27 / (var_28 + (var_29 - acosf(tanhf((-0.0f / (+1.0854E-44f + (+1.1762E-36f * +1.3543E-37f)))))));
}
}
   dump(&comp, sizeof(comp));

}

float* initPointer(float v) {
  float *ret = (float*) malloc(sizeof(float)*10);
  for(int i=0; i < 10; ++i)
    ret[i] = v;
  float* ret2;
	cudaMalloc(&ret2, sizeof(float) * 10);
	cudaMemcpy(ret2, ret, sizeof(float) * 10, cudaMemcpyHostToDevice);
	return ret2;
}

int main(int argc, char** argv) {
/* Program variables */

  float tmp_1 = atof(argv[1]);
  int tmp_2 = atoi(argv[2]);
  int tmp_3 = atoi(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30);
  cudaDeviceSynchronize();

  return 0;
}
