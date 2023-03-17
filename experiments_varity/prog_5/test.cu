
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26) {
if (comp < atanf(+0.0f * (var_1 / (-1.5211E-21f + +1.8764E-41f)))) {
  float tmp_1 = (+1.8938E-7f * (+1.8680E-42f - (var_2 * -1.5427E-36f * (var_3 * +1.7809E-41f))));
comp = tmp_1 + (-1.1484E-43f / -1.2457E5f - (var_4 + var_5 - var_6 - -1.2790E-37f));
comp = +1.2441E-42f * +1.8290E34f;
comp = (-1.3823E-37f / -1.7493E-4f + (+1.8868E-5f + -1.8733E-36f));
if (comp >= -1.5699E27f / var_7 + cosf(var_8 / (+0.0f * var_9))) {
  comp = fmodf(var_10 / -1.4101E-35f - var_11, var_12 / +1.0262E-16f);
comp += powf((var_13 + sinhf(+1.4771E-36f + (-1.6460E-41f * fmodf((+1.1910E34f * log10f(atan2f(expf((var_14 / (var_15 * (var_16 - -1.2970E35f)))), var_17 / var_18 + var_19 - (var_20 + var_21)))), +1.0790E-9f)))), -1.7601E-41f - (+1.2827E-44f / +0.0f - tanhf((var_22 + powf(sqrtf(-0.0f * -1.1247E-36f), -0.0f * var_23 - (var_24 / var_25 + (+1.4942E9f * var_26)))))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27);
  cudaDeviceSynchronize();

  return 0;
}
