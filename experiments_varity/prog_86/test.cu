
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10) {
float tmp_1 = -1.6059E-36f;
comp = tmp_1 + (var_2 - (+0.0f / -0.0f + -0.0f));
comp = var_3 / (+1.3843E-22f * var_4 + (+1.2547E2f + -1.0924E-43f));
if (comp <= sinf((var_5 - -0.0f * +1.3446E35f - -1.2055E-35f * (var_6 / var_7)))) {
  comp = ldexpf(+1.7518E36f / -1.5137E-42f / asinf(-1.5513E24f + (var_8 * +1.3731E-21f)), 2);
float tmp_2 = -1.6911E-42f;
comp += tmp_2 * (-1.8404E-3f / var_9);
}
for (int i=0; i < var_1; ++i) {
  comp = fabsf(var_10 / (+0.0f / +1.4986E11f * +1.7254E-36f));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11);
  cudaDeviceSynchronize();

  return 0;
}
