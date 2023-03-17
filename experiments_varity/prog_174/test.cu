
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14) {
for (int i=0; i < var_1; ++i) {
  if (comp <= var_3 * -1.0111E-42f) {
    for (int i=0; i < var_2; ++i) {
      comp += +1.9573E35f * var_4 + (var_5 - (-0.0f - var_6));
float tmp_1 = +1.9881E-37f;
comp = tmp_1 - (-1.8594E-43f * var_7 + -1.4813E-43f / -1.4732E34f);
if (comp <= +1.7059E-37f + (-1.1710E-23f / -1.6079E-37f * (var_8 + -0.0f - var_9))) {
  float tmp_2 = -1.9125E19f * (-1.7493E-44f / (var_10 / var_11));
float tmp_3 = -0.0f * (+1.3786E-41f * sqrtf((+1.9976E-42f + fabsf((var_12 + +1.0464E-10f * floorf(sinf(-1.8859E-42f)))))));
comp += tmp_3 * tmp_2 * var_13 * sqrtf(-1.5827E-3f + +1.0035E-35f / -0.0f / (var_14 / -1.1672E34f));
}
}
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15);
  cudaDeviceSynchronize();

  return 0;
}
