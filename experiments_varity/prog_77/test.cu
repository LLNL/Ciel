
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10) {
if (comp > (-1.3943E-36f / +0.0f - (var_2 / var_3))) {
  float tmp_1 = +1.5186E28f;
float tmp_2 = -1.1281E-1f;
comp += tmp_2 * tmp_1 / cosf(logf(-1.2048E7f));
comp += coshf((-1.0964E34f * -1.2267E-44f - var_4));
if (comp < (var_5 * var_6)) {
  float tmp_3 = (+1.3174E28f - +0.0f);
float tmp_4 = +1.8966E-7f;
comp += tmp_4 * tmp_3 * -1.5344E-44f / (+1.0506E18f * (var_7 - (+1.6832E19f - +1.2449E-36f)));
}
for (int i=0; i < var_1; ++i) {
  float tmp_5 = +1.7930E-43f + (-1.3392E35f / logf((+1.7318E0f * -1.4533E-41f)));
comp += tmp_5 - var_8 / fmodf(+1.3093E-43f, +1.7079E34f + (var_9 * -1.9509E35f - var_10));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11);
  cudaDeviceSynchronize();

  return 0;
}
