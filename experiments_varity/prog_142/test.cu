
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    if (comp == (+1.5313E-36f / ceilf((+1.6284E36f - (+1.0025E-41f * -1.2651E8f + (var_3 - -1.7601E35f)))))) {
      if (comp >= var_4 + var_5) {
        comp += +1.8030E-43f / var_6 - (-1.0470E-42f - (var_7 - var_8 + -1.4209E-35f));
if (comp == -1.5788E35f + var_9 / +1.0406E34f) {
  float tmp_1 = -1.7972E-42f * var_10 / -0.0f - var_11;
comp = tmp_1 - var_12 * acosf((var_13 + log10f(var_14 - atan2f(+1.8996E-36f - (-1.8740E-13f * +1.2035E-43f), (-1.0843E-35f + var_15)))));
}
if (comp <= (-1.4347E-43f + -1.7775E-5f)) {
  comp = (-1.0505E34f / var_16);
comp = asinf((var_17 - coshf(-1.8440E-43f)));
comp += coshf((var_18 * var_19 - var_20 / +1.9798E36f * -1.2569E34f * -1.6270E5f));
}
}
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21);
  cudaDeviceSynchronize();

  return 0;
}
