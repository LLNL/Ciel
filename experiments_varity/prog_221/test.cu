
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
comp += (var_3 + -1.4978E-41f);
for (int i=0; i < var_1; ++i) {
  comp += (var_4 / log10f((-0.0f - (var_5 / (var_6 / powf(+0.0f, -1.6087E8f * fabsf(+1.8141E-41f * (-0.0f + +0.0f + var_7))))))));
}
for (int i=0; i < var_2; ++i) {
  float tmp_1 = (-1.5355E-43f * asinf(-0.0f));
comp += tmp_1 + (+0.0f / (+0.0f + (var_8 - var_9 / (+1.7480E-42f * +0.0f))));
comp += coshf(-1.9356E-36f / var_10 + -1.6899E27f);
comp += (var_11 * -1.9931E-9f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12);
  cudaDeviceSynchronize();

  return 0;
}
