
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float* var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
for (int i=0; i < var_1; ++i) {
  comp = -1.8594E-36f + var_5;
var_2[i] = sqrtf(+1.7597E35f);
comp += var_2[i] * var_6 + +0.0f - var_7 * var_8;
for (int i=0; i < var_3; ++i) {
  float tmp_1 = tanhf(-1.1087E-35f * +1.7744E5f);
comp += tmp_1 * atan2f((var_9 - fabsf(-1.7188E-44f * var_10 * var_11 / +1.6139E-25f)), +1.6777E-42f * (var_12 + +1.8675E19f));
comp += (+1.8075E-37f / -1.1232E35f - sinhf(+1.9562E-35f + +1.5666E36f - asinf((-1.5036E34f + -1.6966E19f * -0.0f))));
}
for (int i=0; i < var_4; ++i) {
  comp = +1.1746E-35f - var_13 / var_14 / var_15;
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
  float* tmp_3 = initPointer( atof(argv[3]) );
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
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
