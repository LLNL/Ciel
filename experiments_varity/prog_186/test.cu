
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33,float var_34,float var_35,float var_36,float var_37,float var_38) {
for (int i=0; i < var_1; ++i) {
  comp = (var_2 + fabsf((var_3 / +1.9136E15f / sqrtf(coshf((var_4 - asinf(atan2f((+0.0f + var_5 - var_6), -1.5388E35f * +1.2421E-44f * -1.6542E-37f + var_7 + (var_8 - -1.4934E-37f)))))))));
comp += logf(sinf((var_9 - -1.3067E19f)));
if (comp > log10f(-1.3278E-35f - var_10 * (-0.0f * coshf(var_11 * (-0.0f + var_12 - (var_13 + var_14 / -1.3503E-41f)))))) {
  comp += var_15 + var_16 * -1.4411E17f - +1.1367E24f - var_17;
float tmp_1 = (var_18 / (+1.3119E35f * +1.5619E-41f / var_19 - +0.0f));
comp = tmp_1 / (+1.3306E34f / var_20);
}
if (comp > atanf(+0.0f)) {
  comp += asinf(floorf(var_21 * -0.0f + +0.0f + floorf(-1.8509E34f)));
comp += -0.0f * (-1.0659E35f / var_22 + var_23 / (-1.3743E-28f / -1.2585E-42f));
comp += var_24 * var_25 * var_26 + var_27;
}
if (comp > -1.2813E-37f + +1.3921E-37f * (var_28 + floorf((var_29 / log10f((-0.0f / tanhf((-1.9777E-37f + var_30 + (var_31 + (var_32 - (+1.1346E36f + var_33))))))))))) {
  comp = logf((var_34 / ldexpf(atanf(var_35 * sinhf((+0.0f - sinf(var_36 / (var_37 + (-1.9344E-37f / var_38)))))), 2)));
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
  float tmp_34 = atof(argv[34]);
  float tmp_35 = atof(argv[35]);
  float tmp_36 = atof(argv[36]);
  float tmp_37 = atof(argv[37]);
  float tmp_38 = atof(argv[38]);
  float tmp_39 = atof(argv[39]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34,tmp_35,tmp_36,tmp_37,tmp_38,tmp_39);
  cudaDeviceSynchronize();

  return 0;
}
