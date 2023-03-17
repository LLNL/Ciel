
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
for (int i=0; i < var_1; ++i) {
  if (comp >= var_2 * -1.8049E-43f) {
    float tmp_1 = (+1.9527E36f / (var_3 / sqrtf(+1.5693E-36f - +1.5835E-35f - +1.8234E35f)));
comp += tmp_1 + -1.9299E-37f - floorf(+1.1072E-22f * sqrtf(-1.1609E8f));
comp = log10f((var_4 + fmodf((-1.5779E12f + var_5 - var_6 + var_7), sqrtf((var_8 / +1.7904E36f)))));
comp = (-1.1508E35f / (-0.0f * +1.2612E-36f / var_9));
if (comp > tanhf(ceilf((var_10 + (var_11 * var_12))))) {
  comp += -1.5889E-41f * var_13;
float tmp_2 = atan2f((-1.8460E35f + -1.3465E-35f - -1.9502E28f - var_14), var_15 / ldexpf(-1.4185E-43f, 2));
comp = tmp_2 * (var_16 * -1.5689E-36f);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
