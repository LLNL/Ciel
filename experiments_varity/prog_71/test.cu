
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8) {
if (comp < logf(sinhf(ceilf((+1.7086E-43f - -1.7085E23f - var_3 - var_4))))) {
  for (int i=0; i < var_1; ++i) {
    comp += (-1.9086E34f - +0.0f - var_5 - +1.4729E11f);
if (comp > (-1.1909E35f + (+1.7427E-35f * var_6 - -1.1457E35f))) {
  float tmp_1 = +1.4184E-42f;
float tmp_2 = -1.7144E-37f;
comp = tmp_2 / tmp_1 + -0.0f * (-1.7531E36f - var_7 - var_8);
comp += -1.5819E-36f / -1.0345E-12f - -1.3350E10f + +1.7103E-36f;
}
for (int i=0; i < var_2; ++i) {
  comp += (+1.4223E-42f - -1.8436E34f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9);
  cudaDeviceSynchronize();

  return 0;
}
