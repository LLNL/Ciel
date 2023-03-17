
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,int var_7,int var_8,int var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    if (comp > logf((var_3 - var_4 + var_5 / var_6))) {
      comp += acosf(-1.3222E-26f / -1.2847E34f / (-1.2264E-37f * (-1.6205E22f * var_10)));
comp += +1.0841E36f * asinf(sinhf(var_11 - +1.5999E-41f));
for (int i=0; i < var_7; ++i) {
  comp += var_12 - +1.3383E-36f;
comp += var_13 - atanf((var_14 / var_15 + var_16));
}
for (int i=0; i < var_8; ++i) {
  comp = var_17 + var_18 / ceilf(+1.1712E-2f);
}
for (int i=0; i < var_9; ++i) {
  comp = var_19 * acosf(var_20 * +1.7187E-37f * +1.3104E-36f);
float tmp_1 = +1.6491E-44f;
comp = tmp_1 / (+1.5345E36f - var_21);
}
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
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  int tmp_8 = atoi(argv[8]);
  int tmp_9 = atoi(argv[9]);
  int tmp_10 = atoi(argv[10]);
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
