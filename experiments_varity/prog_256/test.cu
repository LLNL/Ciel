
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    if (comp == (+0.0f * (var_3 - (-1.1451E-42f + log10f((-1.9301E19f * atan2f(+1.0375E34f - +1.3706E35f, +1.0134E-42f))))))) {
      if (comp > (+0.0f + (-1.4757E-42f + (+1.9893E-36f + var_4 / -1.0768E-37f)))) {
        comp += (+1.6657E4f + var_5);
float tmp_1 = (+1.3109E-15f * +0.0f * -1.6854E-37f);
comp = tmp_1 / (var_6 - var_7 + +1.1093E-42f);
if (comp >= +1.0722E-37f - (-1.1822E-36f / (var_8 * (+1.4011E-35f * var_9)))) {
  comp += (var_10 - -1.3518E-44f + (var_11 * -1.9255E-9f * (var_12 + -1.9572E-35f)));
}
if (comp == (var_13 + sinf((-1.7602E34f * var_14)))) {
  comp = (var_15 - sinhf(ceilf(log10f((+1.0229E35f * (-1.5434E-44f / var_16))))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
