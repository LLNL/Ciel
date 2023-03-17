
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9) {
float tmp_1 = +1.0038E-36f - (var_1 - -1.4921E-37f + (var_2 / +1.5454E-35f));
comp += tmp_1 - (-0.0f * var_3 / var_4 + (-1.4969E35f * +1.6195E36f / +1.1516E35f));
if (comp == (var_5 - +1.8212E-37f)) {
  float tmp_2 = -1.6362E-22f;
comp = tmp_2 + var_6 / (var_7 / (+1.5262E34f / (+1.8580E25f + expf((+0.0f / (var_8 / ldexpf(floorf(var_9 * +0.0f * -1.8698E-35f), 2)))))));
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
