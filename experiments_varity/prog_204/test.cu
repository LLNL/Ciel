
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10) {
for (int i=0; i < var_1; ++i) {
  if (comp == var_2 / (var_3 * log10f(-0.0f + var_4))) {
    comp += +1.4807E-7f - var_6 + (var_7 / asinf((+1.7648E-43f - -1.9257E6f)));
for (int i=0; i < var_5; ++i) {
  comp += sinhf(+1.2551E21f);
float tmp_1 = -1.7369E10f - (var_8 / -1.2251E34f);
comp += tmp_1 - (var_9 * +1.4292E-41f - var_10);
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
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  int tmp_6 = atoi(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11);
  cudaDeviceSynchronize();

  return 0;
}
