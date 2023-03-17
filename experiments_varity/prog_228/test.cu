
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float* var_8,float* var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    comp = var_5 * var_6 / (+1.4955E35f + var_7);
for (int i=0; i < var_3; ++i) {
  comp = (+1.9220E34f - sqrtf(+1.6696E-5f));
var_8[i] = -1.2810E-44f;
var_9[i] = (var_10 / +1.9766E-35f);
comp += var_9[i] - var_8[i] * (+0.0f - (var_11 * +1.5211E-44f));
}
if (comp < (var_12 / (var_13 + var_14 / (var_15 - (+0.0f + var_16))))) {
  comp = (-1.9038E-41f - acosf(var_17 / -0.0f / -0.0f - (+0.0f - (-0.0f * var_18))));
comp += (+1.8471E-42f / +1.0305E35f + -1.8905E35f);
comp = (var_19 / var_20 / -1.2833E-35f / var_21 - +1.5192E-42f);
comp += (+1.9975E-41f / var_22 / var_23 - (var_24 / var_25 + var_26));
}
for (int i=0; i < var_4; ++i) {
  float tmp_1 = (var_27 + +0.0f);
comp += tmp_1 - floorf(fmodf(coshf(+1.8288E-42f), (-0.0f + var_28 / sqrtf((var_29 * -1.5462E-11f / var_30 / var_31 * +1.9347E36f / var_32)))));
comp += +1.2492E-43f * +1.1390E7f;
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
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float* tmp_9 = initPointer( atof(argv[9]) );
  float* tmp_10 = initPointer( atof(argv[10]) );
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
  float tmp_30 = atof(argv[30]);
  float tmp_31 = atof(argv[31]);
  float tmp_32 = atof(argv[32]);
  float tmp_33 = atof(argv[33]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33);
  cudaDeviceSynchronize();

  return 0;
}
