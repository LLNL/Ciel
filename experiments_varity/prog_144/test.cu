
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33,float var_34,float var_35,float var_36,float var_37,float var_38,float var_39,float var_40,float var_41,float var_42) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = sinhf(var_3 * -1.4551E-36f + -1.2625E35f - -1.4661E-43f);
float tmp_2 = (-0.0f + cosf(-1.0306E-37f));
comp += tmp_2 * tmp_1 + var_4 * var_5 * -1.8288E35f;
for (int i=0; i < var_2; ++i) {
  comp += +0.0f - var_6;
}
if (comp >= (var_7 + var_8 - var_9)) {
  comp += var_10 * fabsf(+1.1972E-36f / (-0.0f / (var_11 + +0.0f - var_12)));
comp = (+1.8549E-12f * -1.8673E-44f / var_13);
comp = (-0.0f * (var_14 * -1.6955E-44f + var_15 * var_16));
comp += (var_17 + -1.2955E34f / atanf(ceilf(var_18 + -1.9031E-43f)));
}
if (comp >= (var_19 + -1.8208E34f / var_20 * var_21 * +1.0832E-43f * var_22)) {
  comp = var_23 - powf(floorf((var_24 / (var_25 * expf((var_26 * (-1.5311E-35f + -1.8166E-44f - logf(var_27 / (var_28 / (var_29 + var_30))))))))), atan2f((+1.9611E-36f - log10f((var_31 / var_32 / -1.8654E34f))), var_33 * (var_34 + (+1.2061E-8f + fmodf(var_35 * -0.0f - var_36 / asinf(var_37 / (+1.0358E-43f / -0.0f / (-1.3233E35f * -1.9166E11f * +0.0f))), (-1.9461E-44f / var_38 / +1.0213E-41f))))));
comp += (-1.5714E-44f * (var_39 - var_40 + var_41 / var_42));
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
  float tmp_37 = atof(argv[37]);
  float tmp_38 = atof(argv[38]);
  float tmp_39 = atof(argv[39]);
  float tmp_40 = atof(argv[40]);
  float tmp_41 = atof(argv[41]);
  float tmp_42 = atof(argv[42]);
  float tmp_43 = atof(argv[43]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34,tmp_35,tmp_36,tmp_37,tmp_38,tmp_39,tmp_40,tmp_41,tmp_42,tmp_43);
  cudaDeviceSynchronize();

  return 0;
}
