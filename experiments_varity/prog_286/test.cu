
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12) {
if (comp >= (var_1 - +0.0f)) {
  if (comp >= (var_2 - var_3)) {
    comp += +0.0f + var_5;
float tmp_1 = (var_6 / logf((var_7 - (var_8 + -1.1764E-16f))));
comp = tmp_1 + (var_9 - (+0.0f + (-1.3204E34f * (-1.3519E-42f - (-1.6717E34f / var_10)))));
for (int i=0; i < var_4; ++i) {
  comp = logf((+1.9378E-36f + (var_11 * (var_12 - -1.3730E-42f))));
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
  float tmp_2 = atof(argv[2]);
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13);
  cudaDeviceSynchronize();

  return 0;
}
