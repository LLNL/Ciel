
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
if (comp < expf((var_2 - (+1.5264E-22f / tanhf(sinhf(+1.7187E34f - var_3 + -1.3384E-41f)))))) {
  for (int i=0; i < var_1; ++i) {
    float tmp_1 = -1.5386E-37f / acosf(-1.0170E29f * floorf(-0.0f * sinf(var_4 - -0.0f)));
comp += tmp_1 - acosf(-1.3608E-37f);
float tmp_2 = -1.7865E-42f;
comp = tmp_2 / sqrtf((-1.1519E-36f / atanf((var_5 + (-1.7364E-37f / (+1.2048E-36f - -1.3147E36f))))));
if (comp < var_6 * (+1.4910E-1f - sinhf(var_7 * -1.1515E-36f / +1.0154E36f))) {
  float tmp_3 = var_8 - (+1.6522E35f - var_9 + -1.2971E28f - var_10 * -1.6359E36f);
comp += tmp_3 / (-0.0f * var_11);
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
