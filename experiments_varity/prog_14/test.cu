
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,int var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    for (int i=0; i < var_3; ++i) {
      for (int i=0; i < var_4; ++i) {
        comp = floorf((-0.0f + var_6 / var_7 + var_8 + -1.0887E35f));
comp += (var_9 - (-1.7852E-43f + (var_10 - var_11)));
comp = (+1.7140E12f * var_12 / (var_13 / (var_14 + +1.4414E34f)));
if (comp < var_15 / var_16) {
  comp = (+1.3538E-43f - var_17 + var_18 - +1.5976E36f * +1.4835E-18f);
}
for (int i=0; i < var_5; ++i) {
  comp = (-1.5892E-41f - log10f(var_19 - (var_20 / -1.9491E-35f / (-0.0f + -1.2808E35f))));
comp += (var_21 * var_22 + (var_23 * tanhf(+1.2446E-43f - sqrtf((+1.7592E23f / -0.0f)))));
comp = -1.7490E-37f - (-1.2559E-37f / (-0.0f * var_24 + var_25));
comp += (var_26 * ceilf(+0.0f));
}
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
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
  int tmp_6 = atoi(argv[6]);
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
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27);
  cudaDeviceSynchronize();

  return 0;
}
