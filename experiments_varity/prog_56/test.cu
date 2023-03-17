
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    comp = +1.6770E-41f - var_5;
comp = -1.9317E-44f - (var_6 - +0.0f - sqrtf(-0.0f));
comp = (+1.1100E36f / (+1.9045E-44f / var_7));
for (int i=0; i < var_3; ++i) {
  float tmp_1 = (-1.2530E-37f / coshf(-1.4681E-36f / (+1.5111E-35f * +1.9243E-41f + var_8 / var_9)));
float tmp_2 = -1.6321E36f;
comp = tmp_2 * tmp_1 + (var_10 / var_11 - +1.4189E36f);
}
if (comp == var_12 - +1.8187E36f / -1.0852E-37f + (var_13 + +1.8867E-44f)) {
  comp = (var_14 - (var_15 / (+0.0f - var_16 / (+1.4631E-3f * var_17))));
float tmp_3 = var_18 / var_19 + var_20;
comp += tmp_3 - atanf(+0.0f - (-1.1109E36f / var_21));
comp = (+1.6903E36f / var_22 - +1.5772E-37f);
}
for (int i=0; i < var_4; ++i) {
  comp += -1.3680E-37f / +1.7708E36f * +1.1797E-44f + var_23;
comp = var_24 / +1.7194E21f * var_25 / -0.0f;
}
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
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
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
