
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = -1.1926E-37f;
comp = tmp_1 - tanhf(+1.4245E-35f);
comp += -1.5479E-15f / +1.6065E24f * +1.0225E-25f;
comp = sinhf(+1.0151E-41f + (+1.8537E36f - var_2 / -0.0f));
if (comp < cosf(fmodf(coshf(+1.0752E35f), -1.2361E-43f))) {
  float tmp_2 = -1.6446E-4f;
float tmp_3 = log10f(+0.0f + fabsf(sinf((-1.2535E34f * fmodf(+1.7591E34f, atan2f(-1.7437E35f, +1.9583E35f / var_3 + var_4 - +1.7283E-35f - (-0.0f + +1.2275E-44f)))))));
comp = tmp_3 * tmp_2 * (-1.4203E-44f - (-1.7223E34f - +1.1715E36f * logf(+1.5565E0f)));
comp += -0.0f + var_5;
}
if (comp > (var_6 + -1.2499E34f)) {
  comp = -0.0f + +1.5447E-14f;
}
if (comp < -1.3238E-35f + log10f(cosf(-1.1412E-36f * -1.7173E34f / -0.0f))) {
  comp = fabsf(var_7 - var_8 - var_9 + (-1.8882E-20f / var_10));
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
