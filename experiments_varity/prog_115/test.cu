
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
float tmp_1 = var_3 + var_4;
float tmp_2 = +1.9720E12f;
float tmp_3 = +1.2828E-21f;
comp = tmp_3 + tmp_2 - tmp_1 / var_5 * var_6 / atan2f((var_7 / (-1.4202E-41f - -1.5509E-43f * var_8)), (var_9 / coshf((var_10 / (+1.4353E21f + (var_11 / +1.4272E22f / -1.2727E34f - +1.7556E-43f))))));
for (int i=0; i < var_1; ++i) {
  comp += (var_12 * expf(ceilf(var_13 + -1.6095E12f / ldexpf(+1.6936E-36f, 2))));
}
for (int i=0; i < var_2; ++i) {
  comp += +1.8186E6f + logf((-1.8026E-42f - var_14 + (-0.0f * (+1.6522E-44f * var_15 + -1.6749E-35f))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
