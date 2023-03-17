
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14) {
float tmp_1 = (+1.2464E29f / +1.9244E-44f);
float tmp_2 = var_2 / +1.8943E-44f - (var_3 - -1.1311E14f);
comp = tmp_2 - tmp_1 + -1.1825E-36f * var_4 * -1.1172E-37f;
if (comp < (var_5 - ldexpf(atanf(var_6 * -1.3105E-35f * (+1.6858E-35f * var_7 - (+1.3891E35f - var_8))), 2))) {
  comp += ceilf(-0.0f + +0.0f + -1.6484E-27f);
}
for (int i=0; i < var_1; ++i) {
  comp = (+1.7501E34f + (-1.5713E36f * +1.9343E-37f * -1.4231E-42f));
comp = (var_9 / var_10);
}
if (comp <= (+1.2267E23f / -1.3600E-44f + (+1.0749E-4f - var_11 / (-1.5771E36f / var_12)))) {
  comp = (var_13 - (var_14 - sinhf(+1.2679E-37f / -1.6524E-18f)));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15);
  cudaDeviceSynchronize();

  return 0;
}
