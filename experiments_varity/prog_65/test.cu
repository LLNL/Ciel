
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13) {
comp = (-1.6784E-35f + floorf(floorf((+1.9068E-20f + (-1.1894E26f - var_2 * var_3)))));
comp = logf((-1.2891E29f + powf((var_4 + +1.5339E36f - (-0.0f / var_5 - (+1.2398E12f * var_6))), var_7 - (var_8 + ldexpf(+1.6265E-28f, 2)))));
for (int i=0; i < var_1; ++i) {
  comp += cosf(+1.8719E-43f - var_9);
comp = var_10 * (var_11 * +1.8486E36f);
comp = -1.4844E-42f - var_12;
}
if (comp >= -1.6559E-42f + +1.6071E35f + -0.0f) {
  float tmp_1 = +1.0867E-14f;
float tmp_2 = (+1.7519E-37f / sqrtf(var_13 - -1.6463E17f));
comp += tmp_2 + tmp_1 / +0.0f - tanhf(+0.0f * +0.0f);
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
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14);
  cudaDeviceSynchronize();

  return 0;
}
