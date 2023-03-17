
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
for (int i=0; i < var_1; ++i) {
  comp = coshf(var_2 - (-1.7378E23f + (var_3 / (+1.8335E-42f + var_4))));
comp = (+1.5395E-41f / sinf((var_5 - floorf(-1.4379E-35f - (+1.5941E-43f - -1.0407E-24f - -1.5079E-36f - -0.0f)))));
float tmp_1 = +0.0f;
comp = tmp_1 * (-1.4513E-44f / var_6);
if (comp == var_7 - var_8 - +1.9090E-37f / +1.6882E36f) {
  comp = var_9 - var_10;
comp += var_11 * (-1.3228E-35f / (+1.1695E20f * (-1.5240E35f * (+1.6842E-18f / +1.3278E-44f))));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12);
  cudaDeviceSynchronize();

  return 0;
}
