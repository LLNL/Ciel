
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32) {
comp = -1.2201E4f - (-1.0292E8f - ldexpf((var_2 - (+1.8362E36f + var_3)), 2));
float tmp_1 = var_4 * +1.1051E36f / +1.6872E25f - +1.5355E35f;
comp += tmp_1 / logf(floorf(cosf(fmodf((var_5 - var_6 * -1.8305E-36f), (-1.4240E-44f - var_7)))));
comp += var_8 / acosf(var_9 + atanf(+0.0f));
for (int i=0; i < var_1; ++i) {
  comp += ldexpf(var_10 + (+1.1009E7f / var_11 / var_12 - (var_13 * var_14)), 2);
comp = +1.1117E35f - (-1.6178E-37f - var_15 / var_16 - -0.0f - -1.0436E18f);
comp = +1.1063E-42f - ldexpf((+1.3389E26f / asinf(-1.3196E-44f + var_17 / (-1.5437E17f - var_18))), 2);
}
if (comp >= var_19 / var_20 + +1.4726E35f) {
  float tmp_2 = fabsf(+1.0581E-41f);
comp += tmp_2 - (var_21 - var_22);
comp = (+1.4737E-42f + -1.9420E20f);
comp += (+1.4486E36f + +0.0f / fabsf(-1.7514E-36f / +1.0238E-44f - -0.0f / (var_23 * var_24)));
}
if (comp < (-1.3332E-36f - -1.2121E-42f - (var_25 + var_26))) {
  comp += ldexpf(-1.2136E-43f, 2);
comp = (+1.0368E-36f / -0.0f);
comp = (-1.6321E34f * (-0.0f - powf((-1.6334E-35f * (+1.8962E35f * (var_27 * (+1.1051E-41f + var_28)))), +1.5735E-43f + (var_29 * var_30 / var_31 - var_32))));
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
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);
  float tmp_31 = atof(argv[31]);
  float tmp_32 = atof(argv[32]);
  float tmp_33 = atof(argv[33]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33);
  cudaDeviceSynchronize();

  return 0;
}
