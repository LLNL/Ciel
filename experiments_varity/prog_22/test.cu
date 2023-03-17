
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float* var_12,float var_13) {
float tmp_1 = +1.1132E-37f;
float tmp_2 = -1.3383E-28f * var_4 / +1.0794E-36f;
comp += tmp_2 - tmp_1 / (var_5 + +1.4975E-44f - var_6);
comp = (-1.1945E-17f * var_7);
for (int i=0; i < var_1; ++i) {
  comp += var_8 * -1.5590E29f + (-1.8040E36f / var_9);
}
for (int i=0; i < var_2; ++i) {
  comp += (var_10 + (var_11 * -0.0f));
}
for (int i=0; i < var_3; ++i) {
  comp += (-1.4003E35f / (var_13 / -0.0f));
var_12[i] = -1.1611E-43f;
comp += var_12[i] / -0.0f - (+0.0f - -1.5122E-43f * -1.2162E34f);
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
  float* tmp_13 = initPointer( atof(argv[13]) );
  float tmp_14 = atof(argv[14]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14);
  cudaDeviceSynchronize();

  return 0;
}
