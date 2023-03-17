
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float* var_4,float var_5,float var_6) {
comp = -1.8675E-37f / (-1.3941E-18f / +1.3800E-43f - (-1.6037E-9f / var_2));
float tmp_1 = -1.9551E34f;
comp += tmp_1 / (+1.5946E-26f - var_3);
for (int i=0; i < var_1; ++i) {
  var_4[i] = -1.5607E-42f;
float tmp_2 = -0.0f;
comp += tmp_2 * var_4[i] / (var_5 / coshf((var_6 * +1.3524E-41f)));
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
  float* tmp_5 = initPointer( atof(argv[5]) );
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7);
  cudaDeviceSynchronize();

  return 0;
}
