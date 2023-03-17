
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33) {
if (comp <= fmodf((var_1 * -1.8254E-35f / -1.6689E35f / (var_2 * (var_3 / var_4))), -1.7343E21f)) {
  float tmp_1 = var_6 * -1.6855E-36f;
float tmp_2 = +0.0f;
comp = tmp_2 * tmp_1 * var_7 - logf(var_8 - +1.1338E-23f);
comp = var_9 + (+0.0f * var_10 / var_11 * -1.3318E34f);
if (comp <= var_12 / var_13 - var_14 * acosf(var_15 + +1.3878E-42f * var_16 * sinf(fmodf(var_17 - var_18, (+1.3409E34f - var_19 / (-0.0f - powf(var_20 / (+1.5133E10f / var_21 + (var_22 + var_23)), -1.0736E34f))))))) {
  comp = var_24 + floorf(acosf((var_25 / var_26)));
float tmp_3 = -1.1663E36f;
float tmp_4 = -1.2158E36f;
comp += tmp_4 + tmp_3 - sqrtf(var_27 - +1.5496E-41f);
}
for (int i=0; i < var_5; ++i) {
  float tmp_5 = (var_28 - (-1.7661E29f - var_29));
comp += tmp_5 - var_30 + -1.1375E-20f / +1.5173E-19f;
comp += (+1.7534E35f / var_31 / var_32 * +1.1428E36f - -1.8270E36f);
comp += floorf((var_33 * -1.0072E-37f));
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
  int tmp_6 = atoi(argv[6]);
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
  float tmp_33 = atof(argv[33]);
  float tmp_34 = atof(argv[34]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34);
  cudaDeviceSynchronize();

  return 0;
}
