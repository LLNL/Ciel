
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23) {
comp = var_2 + var_3 - sinf((var_4 + (+1.2894E-41f / var_5)));
comp = (var_6 * +1.8840E7f + (-1.1719E-36f * (var_7 / (-1.6936E-37f + var_8))));
float tmp_1 = -1.1775E-43f;
comp += tmp_1 * var_9 / (var_10 + -1.1235E17f - var_11);
for (int i=0; i < var_1; ++i) {
  comp = (var_12 - var_13);
}
if (comp > sinf((+1.4881E36f / (-1.4537E-43f * var_14 * (var_15 + log10f((-1.3986E-11f / (-1.5525E-42f / -1.7609E14f + log10f(-1.4843E36f - var_16 * (+0.0f / asinf((var_17 - +1.7630E35f)))))))))))) {
  comp = (var_18 - (+1.2324E-44f * +1.7307E10f));
float tmp_2 = (+1.0020E-35f - var_19 * -1.5871E-44f / atan2f(expf(-1.9903E-17f), -1.1727E36f));
comp += tmp_2 / var_20 * tanhf(var_21 - (var_22 - var_23));
comp = -1.3157E34f / +1.7804E-35f / +1.4261E-37f;
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24);
  cudaDeviceSynchronize();

  return 0;
}
