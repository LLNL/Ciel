
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float* var_3,float var_4) {
if (comp == floorf(-0.0f)) {
  float tmp_1 = +1.3963E-6f;
comp += tmp_1 - (+1.6619E35f * var_2 - -1.5939E-42f);
for (int i=0; i < var_1; ++i) {
  comp += log10f(floorf(sinf((+1.8762E35f - (+1.5776E-44f / var_4)))));
var_3[i] = asinf(-1.0657E-26f);
float tmp_2 = -1.9984E-7f;
comp = tmp_2 - var_3[i] * (+0.0f + (-1.9173E13f / -1.6537E25f));
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
  float* tmp_4 = initPointer( atof(argv[4]) );
  float tmp_5 = atof(argv[5]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5);
  cudaDeviceSynchronize();

  return 0;
}
