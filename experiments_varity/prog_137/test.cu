
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
float tmp_1 = -1.0724E35f;
comp = tmp_1 + (+1.7351E-25f + -1.3599E34f - -1.7297E-35f / var_2);
comp += (var_3 * var_4);
for (int i=0; i < var_1; ++i) {
  comp = var_5 / tanhf((+1.1204E36f / var_6 + (-1.2426E-35f * var_7 * atanf((-1.6000E36f - sqrtf(-1.2593E-44f - -1.8579E6f - var_8 / (var_9 + var_10 - var_11)))))));
comp += (-1.5310E-35f * (-1.4679E-1f * powf((-1.9050E-27f - +1.6574E-25f - var_12), logf(+1.9970E-43f))));
comp = -1.5322E-44f + +1.0538E36f * (var_13 + var_14 / var_15);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
