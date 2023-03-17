
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7) {
comp = (+1.7403E-37f / +1.0513E-3f);
if (comp <= ceilf(+1.7902E19f)) {
  float tmp_1 = (var_2 + fabsf(-1.8896E18f - var_3 + -1.1632E-36f));
comp += tmp_1 * var_4 - (+1.3793E-44f + var_5);
}
for (int i=0; i < var_1; ++i) {
  comp += +1.6315E-24f - +1.1241E34f;
float tmp_2 = -1.9265E4f;
comp += tmp_2 - fabsf(+1.2871E-36f / var_6 - var_7);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8);
  cudaDeviceSynchronize();

  return 0;
}
