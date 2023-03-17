
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float* var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19) {
if (comp <= (-0.0f - var_2 + var_3)) {
  float tmp_1 = (-1.2778E-37f + -0.0f);
comp = tmp_1 / (+0.0f * var_4 * (var_5 + ldexpf((-1.7950E36f - var_6), 2)));
for (int i=0; i < var_1; ++i) {
  comp = (var_8 + var_9);
var_7[i] = -0.0f + var_10;
comp = var_7[i] - +1.0158E-37f - (+1.5951E-44f + var_11 / sqrtf(-1.2438E36f));
}
if (comp >= (+0.0f - (+1.9889E36f / (+1.2658E-35f - (var_12 * (var_13 / var_14)))))) {
  float tmp_2 = +1.9292E-41f;
float tmp_3 = ldexpf(var_15 * var_16 + (var_17 + var_18), 2);
comp += tmp_3 / tmp_2 + var_19 * -1.4964E-14f;
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
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float* tmp_8 = initPointer( atof(argv[8]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20);
  cudaDeviceSynchronize();

  return 0;
}
