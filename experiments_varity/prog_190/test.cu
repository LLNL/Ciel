
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17) {
float tmp_1 = -0.0f;
comp += tmp_1 - var_2 / var_3;
if (comp > log10f((-1.9656E-44f + (-0.0f - var_4)))) {
  comp += +1.2566E35f * floorf((+1.3411E-42f / -1.4854E6f * (+0.0f * (-1.5597E-37f / var_5))));
}
if (comp >= asinf(-0.0f * (+0.0f - (var_6 * +1.8632E-36f)))) {
  float tmp_2 = -1.0954E-42f;
comp = tmp_2 - sqrtf(+1.3396E16f - -1.0856E-26f + var_7 + (var_8 * +1.3301E-41f));
float tmp_3 = (-1.0335E-36f * -1.9535E35f - var_9);
comp += tmp_3 - (var_10 - +1.0314E-36f);
}
for (int i=0; i < var_1; ++i) {
  comp = (-1.9095E36f - +1.4898E34f - -1.2372E-42f + (var_11 - -1.0286E-20f));
comp += var_12 * fabsf(+1.4056E-36f);
comp = var_13 + var_14 - var_15 / powf(-1.2869E35f, +1.6324E-3f * powf(-1.7454E34f, -1.3934E34f * (-1.6833E-35f - (var_16 + +1.1709E15f * (var_17 + -1.0814E-43f)))));
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
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18);
  cudaDeviceSynchronize();

  return 0;
}
