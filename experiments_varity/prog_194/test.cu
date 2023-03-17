
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float* var_13,float* var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23) {
comp = +1.8369E13f + +1.5231E19f - -1.1416E-30f;
float tmp_1 = (-1.6147E24f + var_3);
comp = tmp_1 * +1.6122E-25f + +1.0583E-44f;
comp += (var_4 / -1.2922E-30f + var_5 + var_6);
if (comp == +1.3898E-42f / var_7 + (-1.1999E-36f + (var_8 / var_9 + var_10))) {
  float tmp_2 = sinf(+1.0847E-35f / (-1.8160E-43f * var_11));
comp = tmp_2 / fabsf((var_12 * (-1.5792E19f / +0.0f)));
}
for (int i=0; i < var_1; ++i) {
  comp = (var_15 - var_16);
var_13[i] = var_17 / (var_18 - -1.9131E-22f + (var_19 + +1.7892E34f));
var_14[i] = +1.0286E-37f;
comp += var_14[i] * var_13[i] * (var_20 * (var_21 / +1.8649E-23f));
}
for (int i=0; i < var_2; ++i) {
  comp = ldexpf(var_22 + (var_23 * (-0.0f - (+1.3815E-42f - +1.8187E-35f))), 2);
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
  float* tmp_14 = initPointer( atof(argv[14]) );
  float* tmp_15 = initPointer( atof(argv[15]) );
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24);
  cudaDeviceSynchronize();

  return 0;
}
