
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float* var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    comp += (var_4 / var_5);
for (int i=0; i < var_3; ++i) {
  comp = (-1.4981E-27f * fabsf(+0.0f));
comp = var_7 * expf(-1.0115E-44f);
var_6[i] = -1.6598E-41f * (-1.3358E34f - log10f((var_8 * sinhf(+1.3993E-37f + (-1.9420E4f * +1.4445E-43f / -1.5239E34f)))));
comp = var_6[i] - var_9 * (+1.3838E-35f / (+0.0f + (-1.8751E34f / var_10)));
}
if (comp == (var_11 + +1.3706E-36f)) {
  float tmp_1 = asinf(-1.4726E23f + -0.0f * (+1.0269E-35f / var_12));
comp = tmp_1 + (-1.1191E36f * powf(-1.8951E-43f, var_13 / sqrtf((var_14 + (var_15 + logf(-1.1694E-3f - acosf((-1.0170E34f - (var_16 + (+1.0204E-12f * var_17))))))))));
comp = var_18 * var_19 + -1.8301E-10f - var_20 + var_21 * -1.8279E-4f;
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
  float* tmp_7 = initPointer( atof(argv[7]) );
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
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22);
  cudaDeviceSynchronize();

  return 0;
}
