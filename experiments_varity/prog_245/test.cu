
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25) {
for (int i=0; i < var_1; ++i) {
  comp += var_3 + powf((var_4 * var_5), (-1.9858E-44f - acosf((+1.0257E-26f - powf((var_6 + asinf(fabsf((var_7 * ldexpf(+1.8798E35f, 2))))), +1.5273E34f * asinf(-1.8499E-37f * (-1.2484E-36f + (var_8 + var_9 * (+1.2591E-41f + var_10)))))))));
comp = +0.0f * (-1.6673E-35f - (var_11 + (-1.3009E-35f - (+1.1342E35f - +1.4982E-35f))));
comp += -1.3040E34f + +0.0f / var_12 - (-1.9604E21f + coshf(-1.3701E-42f / (-1.0553E36f / -0.0f + fmodf((+1.1148E34f + +1.2900E-27f * var_13), sinhf(+1.4706E35f * (+1.6873E-36f * (-1.2804E-43f - (+1.5872E-41f + -1.7754E34f))))))));
if (comp >= (var_14 + var_15)) {
  float tmp_1 = -0.0f;
float tmp_2 = -1.5222E-35f;
float tmp_3 = +1.9014E36f;
comp = tmp_3 - tmp_2 + tmp_1 * atanf(log10f((var_16 * -1.5509E-21f * var_17 / var_18)));
}
if (comp > +1.7469E-44f + (-1.6770E-44f + acosf(var_19 + +1.1268E36f))) {
  float tmp_4 = (-1.6707E-42f - (var_20 - atanf(var_21 - -1.9621E13f / var_22 - -0.0f)));
float tmp_5 = +1.1750E34f;
float tmp_6 = +1.5153E-43f;
comp = tmp_6 / tmp_5 + tmp_4 / +1.7235E12f - var_23 + -1.3209E-42f;
}
for (int i=0; i < var_2; ++i) {
  comp += (+1.7389E-41f + var_24 + var_25 * -1.1585E35f);
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
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26);
  cudaDeviceSynchronize();

  return 0;
}
