
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28) {
for (int i=0; i < var_1; ++i) {
  comp = -1.7997E-35f + (+0.0f * +0.0f + var_3);
comp += sqrtf((var_4 - -1.4648E22f / var_5));
comp += ldexpf(var_6 / -1.9809E12f, 2);
if (comp <= (+0.0f + +0.0f + (var_7 - (+1.4959E-43f * var_8)))) {
  comp = (var_9 - expf(atan2f(var_10 / (-1.1194E36f / (var_11 + -1.2978E3f * (-1.4336E35f - var_12))), (+1.4573E-3f - var_13 / (var_14 - (var_15 + (+0.0f - var_16)))))));
comp = var_17 / var_18;
comp = log10f((var_19 - -1.5014E-41f));
}
for (int i=0; i < var_2; ++i) {
  comp = (+1.5254E-42f - (var_20 - -1.1800E-37f * -1.3755E-36f + (var_21 - +1.4218E-30f)));
}
if (comp < +1.3531E-41f * +1.9980E-41f) {
  float tmp_1 = asinf(fabsf(var_22 + var_23 * (+0.0f / ceilf(var_24 / expf(-0.0f)))));
comp += tmp_1 - sinhf((-1.1886E18f + (-0.0f - var_25 + -0.0f + +1.8785E-43f / var_26)));
comp = (var_27 * -1.9121E3f + var_28 * +1.6747E4f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29);
  cudaDeviceSynchronize();

  return 0;
}
