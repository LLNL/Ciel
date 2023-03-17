
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float* var_20,float var_21,float var_22) {
if (comp < (var_1 + (-1.0618E-14f + var_2))) {
  comp = (var_4 + tanhf((-0.0f + -0.0f)));
comp = log10f(+1.6829E16f);
comp = (var_5 * (var_6 / (var_7 - (var_8 - (+1.9521E-36f * -1.7751E35f)))));
if (comp <= (var_9 + (-1.0013E-44f + cosf((+1.5759E-43f + var_10))))) {
  float tmp_1 = -1.6744E-30f;
float tmp_2 = (var_11 + floorf(asinf(-1.1162E-2f / var_12 * ceilf((var_13 - var_14 + var_15)))));
comp = tmp_2 / tmp_1 - (var_16 / (-1.8482E-42f + ceilf(-1.3313E-44f)));
comp += (var_17 + -1.8945E20f + +1.7824E-36f - var_18 + var_19);
}
for (int i=0; i < var_3; ++i) {
  var_20[i] = +1.9524E-42f;
float tmp_3 = -1.1483E-36f;
comp += tmp_3 - var_20[i] + +1.0162E15f * var_21;
comp += var_22 / +1.2242E36f + -0.0f / -1.6344E-44f;
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
  float tmp_2 = atof(argv[2]);
  float tmp_3 = atof(argv[3]);
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
  float* tmp_21 = initPointer( atof(argv[21]) );
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23);
  cudaDeviceSynchronize();

  return 0;
}
