
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3) {
float tmp_1 = +1.8785E-20f / atan2f((+1.7303E-35f / acosf(-1.3519E-35f / var_1)), var_2 / +1.9360E35f);
float tmp_2 = coshf(+1.8422E-44f);
float tmp_3 = +1.8333E35f;
comp += tmp_3 / tmp_2 - tmp_1 * +1.8329E-25f / (-0.0f * var_3);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4);
  cudaDeviceSynchronize();

  return 0;
}
