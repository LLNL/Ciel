
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float* var_4,float* var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24) {
float tmp_1 = -1.7407E-37f;
comp = tmp_1 * (+1.3653E-44f + (+0.0f - var_2 + (-1.3795E-44f * -0.0f / var_3)));
for (int i=0; i < var_1; ++i) {
  var_4[i] = (var_6 / var_7 - (-1.1248E-42f / +1.6267E35f + +1.8051E2f));
var_5[i] = +1.0201E36f;
comp += var_5[i] + var_4[i] - +0.0f + logf(var_8 + (-1.3514E-17f + +1.2480E28f));
comp += var_9 - (-1.0346E9f - var_10 / +1.1852E-37f + (var_11 * -0.0f));
}
if (comp > var_12 * ldexpf(+0.0f, 2)) {
  float tmp_2 = +1.9453E-36f + (var_13 - (-0.0f - +1.8371E-1f / sinf(var_14 + sqrtf(+1.5774E-36f + var_15 / (+1.9933E1f * (var_16 - (+1.0324E-44f * -0.0f)))))));
comp = tmp_2 * (+1.5923E-27f * +1.7855E19f);
}
if (comp == (-1.0437E34f / +1.6834E-37f + (var_17 - var_18))) {
  float tmp_3 = -1.8511E-36f;
comp = tmp_3 + acosf(-0.0f);
comp += (var_19 * var_20 + powf(atan2f(log10f((var_21 + var_22)), +1.7069E27f / ceilf((var_23 - (+1.1874E35f / +0.0f / (-1.0745E-43f / -1.6644E-13f))))), acosf(-0.0f * -1.1551E-37f - var_24)));
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
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float* tmp_5 = initPointer( atof(argv[5]) );
  float* tmp_6 = initPointer( atof(argv[6]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25);
  cudaDeviceSynchronize();

  return 0;
}
