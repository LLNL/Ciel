
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
for (int i=0; i < var_1; ++i) {
  if (comp > (-1.9213E35f + +1.9956E-36f - (var_2 - (var_3 * -0.0f)))) {
    comp += var_4 + +1.5921E-41f / +1.2842E-43f;
if (comp >= var_5 * var_6 / var_7 * +1.0692E36f / var_8) {
  float tmp_1 = -1.0057E-44f;
float tmp_2 = (var_9 / atanf(+1.5578E-42f - var_10 / +1.7388E3f));
comp = tmp_2 / tmp_1 - (-1.8142E-42f + coshf((+0.0f * (-0.0f + var_11 * +1.1072E-37f))));
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
