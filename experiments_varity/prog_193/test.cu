
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4) {
float tmp_1 = (var_2 - (+1.8500E-44f - +0.0f * -0.0f));
comp = tmp_1 - (-1.5346E-37f + -1.5036E27f + (var_3 / -1.0741E-42f));
for (int i=0; i < var_1; ++i) {
  float tmp_2 = +0.0f / -1.7592E35f;
comp += tmp_2 - -1.3442E-36f - (+1.5408E36f * (var_4 * -1.9584E36f));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5);
  cudaDeviceSynchronize();

  return 0;
}
