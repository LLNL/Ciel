
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = +1.0197E-35f + (var_3 - var_4);
comp = tmp_1 + (-1.2326E36f + var_5);
if (comp > (var_6 + logf(logf(var_7 - var_8 / var_9 / (+1.0789E-36f - -1.6791E36f))))) {
  float tmp_2 = +1.7339E-36f;
comp = tmp_2 - (var_10 / +0.0f);
comp = sinf(-1.6953E-36f / atanf(+1.9214E-5f - ldexpf(var_11 * +1.9752E-8f, 2)));
}
if (comp > (-1.9102E35f / var_12 * var_13 * var_14)) {
  float tmp_3 = -1.5097E-37f - var_15;
float tmp_4 = +1.1459E-37f;
comp += tmp_4 - tmp_3 + ceilf(-1.3137E35f);
comp = +1.6520E28f / (var_16 - -1.7487E-36f - +1.4132E-35f + var_17);
}
for (int i=0; i < var_2; ++i) {
  comp += var_18 * -1.4563E28f;
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
  float tmp_19 = atof(argv[19]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19);
  cudaDeviceSynchronize();

  return 0;
}
