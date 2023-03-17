
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float* var_11,float* var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24) {
for (int i=0; i < var_1; ++i) {
  comp = var_3 * floorf(+1.5144E35f);
float tmp_1 = -0.0f + (var_4 + fmodf((var_5 * (+1.1032E-36f - (var_6 * -0.0f + +0.0f))), -1.8364E35f));
comp += tmp_1 * (-1.7594E-25f + (var_7 - var_8 - var_9));
comp += tanhf(floorf(+1.6852E-43f + var_10 * -1.1582E-36f));
for (int i=0; i < var_2; ++i) {
  var_11[i] = -1.6470E-22f;
var_12[i] = +1.0940E36f;
comp += var_12[i] / var_11[i] + (var_13 / (var_14 + var_15));
}
if (comp >= -1.4099E35f + (-1.8257E34f + -1.0592E27f)) {
  comp = var_16 - var_17 / var_18 - -1.7750E-37f / -1.9396E-19f + var_19;
comp += var_20 - -0.0f;
comp += (+1.9299E-37f + (+1.9056E12f / var_21));
comp += var_22 - -1.5014E-36f * log10f(+1.0657E-43f);
}
if (comp > -1.2880E1f / +1.7427E-44f - +1.5180E7f) {
  comp = var_23 - (var_24 / -1.6423E11f);
comp = (+1.4207E-36f - +1.3393E34f + -1.1701E-43f);
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
  float* tmp_12 = initPointer( atof(argv[12]) );
  float* tmp_13 = initPointer( atof(argv[13]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25);
  cudaDeviceSynchronize();

  return 0;
}
