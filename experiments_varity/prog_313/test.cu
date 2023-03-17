
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float* var_2,float* var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25) {
for (int i=0; i < var_1; ++i) {
  var_2[i] = -1.1032E-42f;
float tmp_1 = (+1.2131E-43f - (+1.7832E-35f - (var_5 / +1.7577E24f / fabsf(var_6 / var_7))));
var_3[i] = +1.6061E-21f;
comp += var_3[i] / tmp_1 + var_2[i] / var_8 * var_9;
if (comp >= (-0.0f / +1.0156E35f)) {
  float tmp_2 = var_10 / (+1.6023E-15f - (var_11 * asinf(-0.0f * var_12)));
float tmp_3 = -1.5522E34f / -1.3741E-36f - +0.0f;
comp = tmp_3 - tmp_2 - fabsf((var_13 - (var_14 - +1.5302E26f)));
comp = var_15 / var_16 + -1.9873E34f;
}
for (int i=0; i < var_4; ++i) {
  comp = logf(ldexpf(var_17 * (var_18 * sinf(-1.8472E-29f)), 2));
}
if (comp >= (+1.5056E-44f - var_19 - powf(var_20 / (+1.6543E-15f / (+1.5980E-42f / expf(-1.9057E-42f))), -1.3584E34f))) {
  comp = (var_21 * (var_22 - -1.5530E-43f / var_23));
comp = +0.0f + var_24 + ldexpf((+1.7529E-37f - var_25), 2);
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
  float* tmp_4 = initPointer( atof(argv[4]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26);
  cudaDeviceSynchronize();

  return 0;
}
