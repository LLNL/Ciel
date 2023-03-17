
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = +1.3264E-42f;
comp += tmp_1 * (-1.9199E9f / var_3 * var_4 + var_5 + +1.5096E7f);
comp = (+0.0f + sinf(-1.5775E-41f));
for (int i=0; i < var_2; ++i) {
  comp = var_6 - var_7;
}
if (comp >= (var_8 * var_9 - -1.2121E28f * (var_10 - var_11))) {
  float tmp_2 = (var_12 * (var_13 + (var_14 - (+0.0f + log10f(+1.5220E16f + +1.0982E-15f - var_15)))));
float tmp_3 = floorf(var_16 * var_17);
float tmp_4 = (var_18 - (-0.0f + +1.3257E-41f / (var_19 / var_20)));
comp = tmp_4 * tmp_3 - tmp_2 - (+1.3525E-41f * (+1.2621E34f * (-1.5093E-4f / sinf((var_21 + (+1.1503E-41f + sinhf(-1.3495E-6f)))))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22);
  cudaDeviceSynchronize();

  return 0;
}
