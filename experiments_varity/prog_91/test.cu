
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,int var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float* var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23) {
if (comp == var_1 + (+0.0f / -1.3182E-43f)) {
  comp = (+0.0f * (+1.7948E-41f - (+1.2425E-42f - var_5 / var_6)));
comp += +0.0f - var_7 + (-1.0084E-42f * var_8);
for (int i=0; i < var_2; ++i) {
  comp = var_9 / (+1.0558E-42f - -1.7427E-35f);
}
for (int i=0; i < var_3; ++i) {
  comp = -1.1553E-42f - (var_10 / -1.4254E-43f * ceilf((-1.2995E34f / var_11)));
}
for (int i=0; i < var_4; ++i) {
  comp += (-1.3662E-37f + +1.1758E-42f);
var_12[i] = (-0.0f * powf((+1.0426E-18f / -1.5964E36f), +1.8620E34f - (-1.6251E-35f / var_13)));
comp = var_12[i] + (+1.2858E-36f - sqrtf(expf((+1.6876E-44f / asinf(var_14 / cosf((+1.7135E35f - var_15 / -1.7406E-36f + var_16 * var_17)))))));
comp = var_18 / (var_19 / atan2f((var_20 - (+1.7421E-41f * (var_21 + -0.0f + (-1.6410E-36f / +1.8407E-36f)))), sqrtf((+0.0f + (var_22 * var_23)))));
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
  int tmp_3 = atoi(argv[3]);
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float* tmp_13 = initPointer( atof(argv[13]) );
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24);
  cudaDeviceSynchronize();

  return 0;
}
