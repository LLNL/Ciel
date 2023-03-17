
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float* var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
comp += (+1.5541E-37f + -1.3636E34f);
comp = ldexpf((var_2 / (var_3 * atan2f(-1.0594E-41f - +1.6283E-36f * -1.9377E-21f - (var_4 / (var_5 / +1.8236E-43f)), -1.5945E-36f + var_6 + (-1.3738E16f / +1.1848E36f)))), 2);
for (int i=0; i < var_1; ++i) {
  comp = var_8 * +1.1670E34f - +1.4449E6f;
var_7[i] = fmodf(powf(-1.6888E-41f, +1.7914E-37f), +0.0f);
comp = var_7[i] - (-1.7142E-14f / -0.0f * cosf(fabsf(floorf((+1.6936E-9f + +1.6304E34f - +1.2672E-41f)))));
comp = var_9 * -0.0f * -1.6677E-36f;
}
if (comp > +0.0f + (-1.7399E-44f - floorf(var_10 / var_11))) {
  comp = tanhf((var_12 - +1.7844E34f));
comp = (+0.0f / sqrtf(var_13 - (var_14 / (-0.0f * acosf(+1.6184E-36f)))));
float tmp_1 = -1.8708E-37f;
comp = tmp_1 + (var_15 / var_16);
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
  float* tmp_8 = initPointer( atof(argv[8]) );
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
