
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27) {
if (comp < var_1 + +1.1615E35f) {
  float tmp_1 = (+1.7453E34f + var_2 - var_3 + (-1.0480E29f + var_4));
float tmp_2 = var_5 + -1.6582E-43f / -1.4460E34f;
comp = tmp_2 * tmp_1 * var_6 + (+1.7474E-36f - var_7 / var_8 * +1.2533E19f + -0.0f);
if (comp > (-1.8305E34f * powf((+1.1921E27f - +1.4396E21f - (+1.1645E2f * sqrtf(var_9 / +1.7072E-36f - (+1.0696E-37f + var_10 / (var_11 + -1.8040E-35f))))), (var_12 - var_13 / (var_14 * -1.7745E-44f / -1.5398E-44f * var_15))))) {
  comp = (var_16 / +0.0f);
}
if (comp < (+1.3188E16f * var_17 * (-1.1849E-44f * (-1.8877E-43f + -0.0f)))) {
  comp += var_18 / var_19 - var_20 / (var_21 - (var_22 / var_23));
}
if (comp <= (+0.0f * +1.5448E-35f)) {
  comp = +1.7405E34f * sinhf(+1.5635E-30f + var_24);
float tmp_3 = +1.5378E-43f;
comp = tmp_3 - (var_25 - var_26 * var_27);
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
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28);
  cudaDeviceSynchronize();

  return 0;
}
