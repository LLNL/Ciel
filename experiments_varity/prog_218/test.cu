
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25) {
float tmp_1 = -1.7120E-35f;
comp = tmp_1 / atanf((-1.3472E-44f * var_2));
float tmp_2 = -1.4757E36f;
comp += tmp_2 / (+1.4849E35f * (var_3 - (+0.0f / var_4 * -1.0348E-22f)));
if (comp > asinf(-1.6645E6f)) {
  comp += (-0.0f / var_5);
comp = -1.0268E34f / ceilf((var_6 / (+1.2930E-16f * var_7)));
}
if (comp > (-1.8978E35f / var_8 + var_9)) {
  comp += +1.9970E16f + +1.7339E-3f - sinf(-1.7323E-28f - var_10);
float tmp_3 = +1.5270E-37f - (+0.0f + -1.9261E-35f - (var_11 / var_12));
float tmp_4 = (var_13 - var_14 + powf((var_15 * -1.5619E9f / (var_16 * (var_17 * var_18))), acosf((var_19 / (var_20 / (var_21 + +1.7753E-17f))))));
comp += tmp_4 / tmp_3 + fabsf((var_22 - +1.6365E-42f * -1.1466E35f));
}
for (int i=0; i < var_1; ++i) {
  float tmp_5 = +1.7317E-5f;
float tmp_6 = (+1.0131E35f - (-1.5156E-35f * -0.0f));
float tmp_7 = (+1.6026E-36f - var_23);
comp += tmp_7 * tmp_6 + tmp_5 - -1.3325E24f / atan2f((-0.0f / log10f((var_24 + (var_25 * +1.4263E-36f)))), +0.0f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26);
  cudaDeviceSynchronize();

  return 0;
}
