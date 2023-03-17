
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    float tmp_1 = +1.6666E35f;
comp = tmp_1 * (+1.4838E-42f - (+1.6315E-35f * (var_4 / var_5 + powf(var_6 * (-1.7386E10f + (var_7 * (var_8 + +1.2061E-37f))), -1.4054E35f - atan2f(-1.4572E8f * sinhf(+1.4628E-44f / var_9), log10f((-1.2724E19f / -0.0f / (var_10 / var_11 * -1.5114E-37f - var_12))))))));
comp += (var_13 + var_14);
for (int i=0; i < var_3; ++i) {
  comp = atan2f(-1.4266E-44f, +1.8751E-36f);
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
  int tmp_4 = atoi(argv[4]);
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
