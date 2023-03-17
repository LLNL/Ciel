
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
for (int i=0; i < var_1; ++i) {
  if (comp >= sinf(-1.7216E-22f)) {
    comp = -1.0892E36f * +1.3154E34f;
float tmp_1 = var_3 * atan2f(fmodf(var_4 - var_5 * -0.0f - var_6 + var_7, cosf(var_8 + (+1.8449E-37f / (-1.0696E-37f / atanf(+1.3494E-36f + +0.0f))))), tanhf(-0.0f));
comp += tmp_1 * cosf(-1.7559E34f - var_9 / +1.1626E-36f / var_10);
for (int i=0; i < var_2; ++i) {
  comp += var_11 * (var_12 * +1.7503E-3f * (+1.4228E24f / (-1.4925E-37f * +1.0348E-42f)));
comp += (+1.2734E-41f * var_13);
comp += (var_14 + var_15);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
