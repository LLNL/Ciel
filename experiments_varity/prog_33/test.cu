
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float* var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29) {
for (int i=0; i < var_1; ++i) {
  comp = (var_5 - var_6);
var_2[i] = (+1.2434E34f / (var_7 / (var_8 - var_9)));
comp += var_2[i] + (var_10 - -1.2385E-42f + (var_11 * +0.0f / (-1.9711E34f * +1.8458E34f)));
for (int i=0; i < var_3; ++i) {
  comp = -0.0f + (var_12 + (-1.2628E-44f / sinf(-1.0453E34f - +1.3967E34f + (var_13 * (var_14 / -1.9112E-43f)))));
comp += var_15 / var_16;
comp = (+1.4984E26f + (-1.6015E-44f - ceilf(fmodf((var_17 * +1.0433E-44f), +1.5480E35f))));
comp += -1.5524E34f / (var_18 - +1.6725E34f + var_19);
}
for (int i=0; i < var_4; ++i) {
  comp += (var_20 - var_21);
comp = (var_22 - var_23 + -0.0f);
}
if (comp >= (-1.6943E29f - var_24 / (var_25 / -1.8487E-42f))) {
  comp = expf(-1.1615E34f);
comp = +1.8922E-42f - var_26 + (+0.0f * (-1.8922E34f - (var_27 * var_28)));
float tmp_1 = -1.2620E-41f;
comp += tmp_1 - (-1.5293E-42f * -1.8979E-43f * -0.0f + +0.0f * var_29 * -0.0f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30);
  cudaDeviceSynchronize();

  return 0;
}
