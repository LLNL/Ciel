
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6) {
comp += var_1 + cosf(-1.7142E-41f);
if (comp >= (+0.0f + (+1.0539E-36f * var_2))) {
  comp += ceilf(+1.2944E-43f);
}
if (comp >= (+1.2169E36f / +0.0f + +1.5210E7f - -1.4064E11f)) {
  float tmp_1 = (+1.3233E-43f / (var_3 - var_4 - var_5));
comp = tmp_1 + (+1.7426E-37f - +1.8406E-37f - cosf((-1.6288E-19f * (var_6 + (-1.9929E35f * -1.1170E36f)))));
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
  float tmp_2 = atof(argv[2]);
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7);
  cudaDeviceSynchronize();

  return 0;
}
