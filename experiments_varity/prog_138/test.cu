
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31) {
comp = +1.0262E-21f + tanhf((var_3 - -1.8370E6f + (+1.3846E36f - expf(+1.7265E-37f + -1.3232E36f))));
float tmp_1 = -1.2115E-17f;
comp = tmp_1 / var_4 / (var_5 + (var_6 - var_7));
if (comp == expf(-1.0314E-37f * (var_8 / +1.2603E-35f))) {
  float tmp_2 = -1.2533E36f;
float tmp_3 = (var_9 * asinf((var_10 - var_11 * (var_12 - +0.0f))));
comp = tmp_3 + tmp_2 * (+1.9068E-44f * +0.0f * -1.3626E34f);
comp += sinf(ldexpf(+1.2663E-29f * powf(-0.0f, var_13 - +1.7495E29f + -1.5401E-37f + (var_14 + (var_15 * var_16))), 2));
}
for (int i=0; i < var_1; ++i) {
  comp = acosf(-1.2047E-37f * var_17 - var_18);
comp = cosf(sinhf(+1.8500E25f));
comp = acosf((var_19 + +1.7544E35f));
}
for (int i=0; i < var_2; ++i) {
  comp = var_20 - (-1.8848E35f - sqrtf((+1.4556E35f - (+1.6375E-37f - var_21 - -1.9039E34f + var_22 + var_23))));
comp = fmodf(+0.0f + var_24, (+1.0279E-37f / (var_25 - (var_26 + atan2f((var_27 - logf((var_28 / -0.0f * (var_29 + (var_30 * (+1.5087E34f * var_31)))))), +1.9838E21f)))));
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
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);
  float tmp_31 = atof(argv[31]);
  float tmp_32 = atof(argv[32]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32);
  cudaDeviceSynchronize();

  return 0;
}
