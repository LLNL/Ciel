
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
comp += ldexpf(+1.8980E34f, 2);
comp += ceilf(var_2 * (+1.2572E-44f - var_3));
for (int i=0; i < var_1; ++i) {
  float tmp_1 = +1.4885E35f;
comp = tmp_1 / +1.4882E34f - var_4 + (var_5 / +0.0f);
comp += floorf((+1.2889E-36f * var_6 + +1.9070E-1f + var_7));
comp += +0.0f + -1.6281E-37f + var_8;
}
if (comp >= +1.6991E-37f - +1.6259E36f - asinf(-0.0f * log10f(sqrtf(var_9 + var_10)))) {
  float tmp_2 = (-0.0f - acosf(expf(asinf(logf((var_11 - +0.0f * var_12 / -0.0f))))));
float tmp_3 = +1.4344E-42f;
comp = tmp_3 * tmp_2 + asinf(-1.4016E35f / var_13 * var_14 - (-0.0f / var_15));
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
