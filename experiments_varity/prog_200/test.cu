
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float* var_22,float var_23,float var_24,float var_25,float var_26) {
for (int i=0; i < var_1; ++i) {
  comp += -1.4565E-35f + (-1.8018E-42f * var_4 - (var_5 / (+1.3201E35f * var_6)));
comp = sqrtf(-1.4949E-37f * (var_7 * (+0.0f / (var_8 + var_9))));
if (comp == var_10 / floorf((var_11 - var_12 * -1.2540E-27f + (var_13 * var_14 * var_15)))) {
  comp += (-1.9437E-37f / fmodf(+1.3188E-41f + (var_16 + (+0.0f - (var_17 * var_18))), var_19 + -1.6687E-43f / -1.3414E-15f / (-0.0f + -1.0465E-42f)));
comp += (+0.0f + (var_20 / -1.0655E34f + +0.0f / +1.8548E24f));
comp = var_21 + tanhf(-1.7508E-44f);
}
for (int i=0; i < var_2; ++i) {
  float tmp_1 = +1.9236E-42f;
float tmp_2 = (var_23 + (+1.8576E-43f + (+1.5835E-43f + -1.3130E34f)));
var_22[i] = -1.7754E-41f;
comp += var_22[i] * tmp_2 - tmp_1 + (+0.0f / (-1.9973E-36f * (+0.0f * var_24 + -1.9126E-43f)));
}
for (int i=0; i < var_3; ++i) {
  comp = var_25 * powf(+1.4865E-43f, +0.0f + (var_26 + -0.0f));
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
  float* tmp_23 = initPointer( atof(argv[23]) );
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27);
  cudaDeviceSynchronize();

  return 0;
}
