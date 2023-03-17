
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33,float var_34,float var_35) {
if (comp < var_1 + -1.0521E9f * (var_2 * var_3 - var_4)) {
  comp = ldexpf((+1.9960E-37f / (-1.4857E-35f - var_6 + (var_7 - var_8))), 2);
if (comp > cosf(+1.3397E-44f)) {
  comp = (+1.3889E-44f * (+0.0f + -1.2855E36f + var_9 - +1.7266E34f));
comp = +1.1849E-36f - var_10 - var_11;
comp += var_12 + -1.7855E-41f / (var_13 - tanhf(-1.0058E34f + var_14 - +1.0074E15f + (+1.8686E36f / var_15)));
comp = (+1.6658E-43f / -0.0f);
}
if (comp >= fmodf(fabsf((var_16 + (var_17 - -1.3960E36f))), (var_18 + (-1.0965E36f - cosf(atanf(coshf((var_19 - (var_20 / var_21 - var_22))))))))) {
  float tmp_1 = +1.8913E-41f;
comp += tmp_1 / -1.3136E-35f * var_23 - -1.8562E-42f;
}
for (int i=0; i < var_5; ++i) {
  comp += (+1.7116E-44f * var_24 / var_25 + var_26);
float tmp_2 = (var_27 + (var_28 + var_29));
comp += tmp_2 * var_30 + (var_31 - (var_32 + +0.0f));
comp += (var_33 / (var_34 + var_35 * +1.4589E19f));
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
  float tmp_35 = atof(argv[35]);
  float tmp_36 = atof(argv[36]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34,tmp_35,tmp_36);
  cudaDeviceSynchronize();

  return 0;
}
