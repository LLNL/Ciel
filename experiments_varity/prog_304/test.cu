
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30) {
float tmp_1 = -1.2697E-14f;
float tmp_2 = -1.3468E-36f;
comp += tmp_2 - tmp_1 - ceilf(+0.0f + var_2);
comp += (+1.2694E-44f - log10f(-1.1992E-27f / var_3 - +1.4077E-37f));
if (comp == (-1.4754E-37f + (var_4 / (var_5 * (var_6 * +1.6948E-43f / -1.8290E-41f))))) {
  comp = tanhf((+1.5556E6f * (var_7 * var_8)));
comp += fabsf(var_9 - logf(+0.0f / (var_10 / (var_11 / -1.7520E-35f))));
}
for (int i=0; i < var_1; ++i) {
  comp += fabsf(sinf(fabsf(atan2f((var_12 * (var_13 + var_14 - -0.0f)), var_15 - (var_16 * var_17)))));
comp = sinf(cosf((+0.0f / (var_18 * var_19))));
float tmp_3 = +0.0f - (var_20 * +1.8894E-42f * powf(var_21 + var_22 + (var_23 / -1.2133E36f - var_24), +0.0f + (+1.1637E14f * var_25)));
comp += tmp_3 - -1.8727E-37f - (var_26 / (+1.7552E-23f + floorf(-1.4537E-41f)));
}
if (comp >= +0.0f / cosf(var_27 * +1.1833E-36f / (var_28 * -1.4010E-44f))) {
  comp += var_29 + (-1.5582E7f + +1.8941E35f / -0.0f);
comp = logf(-1.8967E-36f);
comp = ldexpf(var_30 * -1.3929E-43f, 2);
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
  float tmp_31 = atof(argv[31]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31);
  cudaDeviceSynchronize();

  return 0;
}
