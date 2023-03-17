
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29) {
for (int i=0; i < var_1; ++i) {
  comp = (+0.0f + var_2 / +1.4133E-21f);
if (comp > (var_3 / logf((+0.0f * fmodf(+1.6305E-41f * coshf(var_4 * floorf(acosf(+1.3974E-37f / +1.7690E34f * (var_5 + +1.9761E36f)))), (var_6 / (var_7 * (var_8 - log10f(var_9 / expf((var_10 / (+1.2161E-42f / -1.4818E22f - (var_11 * var_12))))))))))))) {
  comp = (var_13 / var_14 - var_15 + logf((-1.4388E36f - +1.0373E34f - (var_16 + (var_17 + var_18)))));
float tmp_1 = -0.0f;
float tmp_2 = +1.7996E-17f / +1.6241E-43f - var_19 + atan2f(-1.0049E-3f, +1.0579E-42f - var_20);
comp = tmp_2 / tmp_1 * +0.0f * var_21 * -1.9009E-36f;
}
if (comp == (+1.9458E-44f * var_22)) {
  float tmp_3 = +0.0f;
float tmp_4 = +0.0f;
float tmp_5 = var_23 / (var_24 / log10f((var_25 * (-1.0542E-28f / acosf((+1.6977E-43f - var_26 * +1.8864E34f))))));
comp = tmp_5 - tmp_4 - tmp_3 + -1.1635E-43f - (var_27 * (+0.0f / var_28 * var_29));
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
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30);
  cudaDeviceSynchronize();

  return 0;
}
