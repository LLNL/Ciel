
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27) {
for (int i=0; i < var_1; ++i) {
  comp = cosf((+1.9055E34f - (var_2 + (+1.0827E-35f / var_3))));
comp += -1.1041E-35f + +1.0652E-41f / ldexpf(+1.7815E-36f, 2);
if (comp < floorf(asinf((var_4 - (+1.7791E-29f * var_5))))) {
  float tmp_1 = -1.1839E-41f;
comp += tmp_1 * ceilf(var_6 + (var_7 / (var_8 / var_9 - var_10 + -1.2745E34f)));
comp = atan2f(var_11 / expf(-1.9505E35f * +0.0f * var_12 + sinhf((var_13 - asinf((+0.0f / +1.5375E-42f * atan2f(+1.0716E19f * +1.8304E34f - var_14 - (var_15 * cosf((var_16 / (-0.0f * (+1.1933E6f / (var_17 * expf(cosf((var_18 + +1.6152E-43f + ceilf(var_19 * var_20 - (+1.8872E-42f / +1.5771E34f / (var_21 + var_22)))))))))))), var_23 - var_24)))))), atan2f(+0.0f + +0.0f + (+1.6800E10f + tanhf(+1.5768E34f)), ceilf(+1.7871E-36f * (var_25 / tanhf((var_26 + (+0.0f / var_27)))))));
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
  float tmp_3 = atof(argv[3]);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28);
  cudaDeviceSynchronize();

  return 0;
}
