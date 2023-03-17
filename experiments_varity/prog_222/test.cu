
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9) {
if (comp < (var_1 / floorf(atanf(-1.7987E-18f)))) {
  float tmp_1 = -1.3824E-44f;
comp = tmp_1 - (var_2 / -1.0897E-42f / -1.3540E-43f / (+1.0519E34f * (+1.9190E35f - var_3)));
comp += (var_4 + expf(+1.8888E-43f * -1.4031E-41f / acosf(cosf(-1.4017E25f))));
if (comp >= (var_5 + (-1.9268E-44f / -1.3701E-37f * (var_6 * (var_7 + +1.6556E-36f))))) {
  comp = tanhf(var_8 * -1.2787E-12f + +1.9470E-36f - +1.1146E-42f / -1.5902E-42f * var_9);
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
  float tmp_2 = atof(argv[2]);
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10);
  cudaDeviceSynchronize();

  return 0;
}
