
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float* var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28) {
if (comp > (-1.7917E-36f / +1.6161E-35f)) {
  for (int i=0; i < var_1; ++i) {
    for (int i=0; i < var_2; ++i) {
      var_3[i] = +1.3808E-43f * (+1.4054E-35f - var_4 - var_5);
comp += var_3[i] - (var_6 - log10f(atan2f(cosf(var_7 - var_8 - +1.8063E35f / +0.0f + var_9), atan2f((var_10 * var_11 * var_12 * fmodf((-1.1895E-35f * -1.2946E-21f + var_13), -0.0f)), +1.0473E0f / +1.1172E36f))));
comp = asinf(-1.8887E19f);
comp = (var_14 / (-1.4624E-37f * -1.3550E25f * +0.0f));
if (comp < -1.3526E-42f * atan2f(-1.2584E-41f + fmodf(var_15 / -1.5098E-37f + (-1.7195E5f * (var_16 / var_17)), (var_18 + +1.4954E28f)), logf(-0.0f))) {
  comp = -1.0378E-35f * -1.9795E35f / -1.3511E-41f - var_19 * -1.1929E16f;
}
if (comp <= (var_20 * (-1.6826E-35f - var_21))) {
  comp = (var_22 / (+0.0f * (var_23 - -1.5127E-42f * -1.6680E15f * -1.2287E-41f)));
}
if (comp > (var_24 - ceilf(-1.8055E-37f * (var_25 + fabsf((+1.5670E-37f / (var_26 * +0.0f - var_27 + (-1.3188E-16f * var_28)))))))) {
  float tmp_1 = +0.0f * +1.8601E20f - -1.4860E35f / -1.4571E36f;
comp = tmp_1 + cosf(sinf(+1.3136E35f));
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
  float* tmp_4 = initPointer( atof(argv[4]) );
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
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
  float tmp_29 = atof(argv[29]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29);
  cudaDeviceSynchronize();

  return 0;
}
