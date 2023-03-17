
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float* var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
comp = +1.6275E-36f * acosf((var_3 * +1.7143E-44f * var_4 * var_5));
for (int i=0; i < var_1; ++i) {
  float tmp_1 = -1.0004E-43f;
var_6[i] = +1.9263E-10f * +1.0626E35f * var_7 / coshf(sinhf(atanf((var_8 + +0.0f * floorf((-0.0f + -1.1158E34f - var_9))))));
comp = var_6[i] + tmp_1 + floorf(sinf((-1.8596E-44f / atanf(fmodf(-0.0f, +1.9840E-37f)))));
comp = (-1.3902E15f - (+1.0030E8f * +1.7903E-18f - -1.9076E-43f));
}
if (comp > -1.9972E-36f / var_10) {
  comp += cosf(+1.2899E-41f * (-1.5746E34f + var_11 / -1.4372E-41f));
comp += (var_12 * cosf(var_13 / +1.7551E34f));
}
for (int i=0; i < var_2; ++i) {
  comp += expf(var_14 * (var_15 * var_16));
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
  int tmp_3 = atoi(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float* tmp_7 = initPointer( atof(argv[7]) );
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
