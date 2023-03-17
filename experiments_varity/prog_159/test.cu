
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2) {
comp += (-1.0551E-19f * (-1.9548E35f - +1.2760E34f * sinf(+1.5972E36f)));
for (int i=0; i < var_1; ++i) {
  comp = (+0.0f / (+1.8596E36f - -1.9720E14f));
comp = var_2 + +1.9419E-44f;
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3);
  cudaDeviceSynchronize();

  return 0;
}
