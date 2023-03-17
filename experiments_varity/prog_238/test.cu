
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
float tmp_1 = -1.5622E-12f;
comp = tmp_1 / var_1 - -1.4215E-36f - (var_2 / +1.9259E-35f);
if (comp >= (-1.4818E35f / +1.1805E-37f - var_3 - -0.0f)) {
  comp = -1.0140E34f / var_4;
float tmp_2 = -1.6795E35f;
comp = tmp_2 + asinf((+1.5713E-17f * +1.8919E-41f / fmodf((var_5 + atan2f(-0.0f, atan2f((var_6 * (var_7 * (var_8 * var_9))), var_10 + (var_11 - var_12 + var_13)))), (+1.1049E-44f - (var_14 * +0.0f + var_15)))));
comp += ldexpf(-1.3949E35f, 2);
}
if (comp <= +0.0f - (-1.7611E-1f / var_16)) {
  comp += tanhf(-1.4925E-35f / +1.5361E34f - -0.0f);
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
  float tmp_2 = atof(argv[2]);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
