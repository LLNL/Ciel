
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float* var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28) {
float tmp_1 = -0.0f;
comp += tmp_1 + var_2 + log10f(+1.6268E-37f + (var_3 / fabsf((+1.2207E-44f / var_4))));
comp += +1.3976E-36f * +1.2060E-22f;
if (comp == var_5 * ceilf((var_6 / var_7))) {
  comp = -1.2546E-44f + (+1.8689E-41f + cosf(ceilf(var_8 + (-1.7557E-41f / atan2f(-1.4001E8f - var_9, -1.7741E34f)))));
comp += var_10 + (+1.2586E-26f - var_11);
comp += (+0.0f * tanhf(var_12 - (var_13 - var_14 - +0.0f * var_15 + var_16)));
comp = acosf((var_17 * +1.3200E3f + var_18));
}
if (comp == +1.5176E-37f / (var_19 - var_20 * (var_21 - tanhf(+1.6729E-35f)))) {
  comp = +1.4572E-44f * +0.0f / -1.7555E-37f * +1.9372E-14f / +1.1579E-35f * -1.3192E-35f;
}
for (int i=0; i < var_1; ++i) {
  var_22[i] = (var_23 + var_24 - +1.9189E-43f * var_25);
comp += var_22[i] - fabsf((var_26 - floorf((var_27 - var_28))));
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
  float* tmp_23 = initPointer( atof(argv[23]) );
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
  float tmp_29 = atof(argv[29]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29);
  cudaDeviceSynchronize();

  return 0;
}
