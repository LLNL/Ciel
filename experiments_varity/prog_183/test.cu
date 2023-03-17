
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float* var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27) {
comp += var_2 - +1.9203E-11f + var_3;
float tmp_1 = (var_4 + (var_5 * (var_6 * var_7 / (-1.1925E-35f - var_8))));
comp += tmp_1 / (var_9 * sqrtf(ceilf(var_10 / (+1.9585E-4f - atanf((var_11 / var_12))))));
for (int i=0; i < var_1; ++i) {
  comp += (-1.8728E28f * (var_14 / -1.1331E-35f));
var_13[i] = -1.1449E36f;
comp += var_13[i] / (+1.6099E19f * (-1.1344E-22f / (+1.8134E-44f * (+0.0f + powf(sinhf((var_15 * (var_16 * atanf(+1.4159E-42f)))), (-1.5757E-19f - -1.4257E-13f))))));
}
if (comp >= (var_17 * var_18)) {
  float tmp_2 = (var_19 - var_20 - +1.2701E10f / +1.8868E-42f + (-1.5387E36f + var_21));
comp += tmp_2 - (-1.3896E-37f * floorf((var_22 / +1.5989E-44f)));
float tmp_3 = +0.0f;
comp += tmp_3 + (var_23 + acosf(-1.2172E35f / -1.2134E-41f - var_24 * var_25 - var_26 + var_27));
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
  float* tmp_14 = initPointer( atof(argv[14]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28);
  cudaDeviceSynchronize();

  return 0;
}
