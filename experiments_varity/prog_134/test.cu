
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11) {
comp += (-1.1816E-43f / tanhf(ceilf(-1.8763E34f)));
comp += logf((-1.3790E-36f / -1.8591E-44f));
for (int i=0; i < var_1; ++i) {
  float tmp_1 = +1.2750E8f;
comp += tmp_1 * (+1.1385E-43f / var_2 - var_3);
float tmp_2 = +0.0f;
comp = tmp_2 * var_4 * (var_5 * (+0.0f * var_6));
}
if (comp <= (var_7 * acosf((+1.5584E-35f / (+1.5569E-35f + (+1.2079E-24f + var_8)))))) {
  comp += (-1.7248E35f * powf(+0.0f, (-0.0f + var_9 - +1.7443E-43f / -1.1671E7f)));
float tmp_3 = +1.3717E34f;
comp = tmp_3 / var_10 + sinhf(-1.0742E-37f);
comp = (var_11 * -0.0f / coshf(-1.7947E-43f));
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
