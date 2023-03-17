
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float* var_9,float* var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19) {
comp = (-1.0688E34f / -1.3079E-44f);
float tmp_1 = +1.9766E20f;
comp = tmp_1 + var_4 - (-1.8696E-36f / (-1.3097E-42f * +0.0f - (+1.4178E-36f * var_5)));
for (int i=0; i < var_1; ++i) {
  comp = (var_6 * atan2f((+0.0f + var_7 - (-1.8006E-37f / +0.0f + var_8)), -1.9124E-35f));
}
for (int i=0; i < var_2; ++i) {
  var_9[i] = +0.0f * (var_11 + (var_12 / var_13));
var_10[i] = (-0.0f + var_14);
float tmp_2 = +1.3214E21f;
comp += tmp_2 * var_10[i] / var_9[i] + var_15 / var_16 + (var_17 / -1.2460E-35f / var_18 - +1.8015E-37f);
}
for (int i=0; i < var_3; ++i) {
  comp += (var_19 * (-0.0f / -1.6370E-20f - +1.0699E34f + +1.8704E-42f));
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
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float* tmp_10 = initPointer( atof(argv[10]) );
  float* tmp_11 = initPointer( atof(argv[11]) );
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
