
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float* var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19) {
for (int i=0; i < var_1; ++i) {
  comp += (var_4 * -1.7769E-35f / (+1.8131E34f / -1.7173E-35f));
comp += (var_5 + (var_6 / (var_7 - (-1.8712E34f / -0.0f))));
for (int i=0; i < var_2; ++i) {
  var_8[i] = +1.2402E36f;
comp += var_8[i] * (-1.1860E35f + (var_9 * fabsf(+1.2819E-8f)));
}
for (int i=0; i < var_3; ++i) {
  comp = (+0.0f * (var_10 / (-1.1915E34f + var_11 / var_12)));
}
if (comp == (-1.5743E-37f / logf((var_13 - (+1.1502E35f + (+1.9065E-43f / (var_14 / var_15 + var_16))))))) {
  comp += var_17 / var_18 / (var_19 - -1.5312E-26f);
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
  float* tmp_9 = initPointer( atof(argv[9]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20);
  cudaDeviceSynchronize();

  return 0;
}
