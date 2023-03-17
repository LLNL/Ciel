
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
if (comp < (-1.3332E2f * (var_1 + +1.9777E-37f + -1.7981E26f / (var_2 - var_3)))) {
  comp = (var_4 / +0.0f / atan2f(+1.1750E-37f, -1.5602E-26f / (+0.0f / (+1.5070E-42f / -1.2048E-36f / var_5))));
float tmp_1 = atanf((var_6 + var_7));
comp += tmp_1 + -1.6271E35f * (-1.0488E-37f / (-1.5361E-41f * var_8 / var_9));
comp += powf(var_10 + -0.0f, (+0.0f / (var_11 * (-1.1546E-26f / +1.1412E-42f))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12);
  cudaDeviceSynchronize();

  return 0;
}
