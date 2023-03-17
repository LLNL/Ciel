
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18) {
if (comp == (var_3 / (+1.7996E35f + (var_4 - (+1.5343E-35f + (+1.7182E-44f * var_5)))))) {
  for (int i=0; i < var_1; ++i) {
    for (int i=0; i < var_2; ++i) {
      float tmp_1 = -0.0f;
comp += tmp_1 / (var_6 - +1.9153E-44f);
if (comp <= var_7 / var_8 - (var_9 / (var_10 / var_11))) {
  float tmp_2 = -0.0f;
float tmp_3 = -1.0340E7f;
comp = tmp_3 / tmp_2 + +1.2027E-36f - var_12;
}
if (comp <= -1.0190E-36f / (var_13 + -1.6377E-36f / (var_14 / var_15 - var_16))) {
  float tmp_4 = -1.7022E34f;
float tmp_5 = +1.0174E-44f;
comp += tmp_5 + tmp_4 * (var_17 - (+1.9672E-25f + (var_18 * -1.7206E-35f)));
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
