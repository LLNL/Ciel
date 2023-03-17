
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
comp += +1.1894E25f + var_2 * var_3;
comp = (var_4 / (var_5 + expf(logf(expf((var_6 - (+1.3359E-35f - (var_7 * +1.2098E-43f + (-0.0f - var_8)))))))));
for (int i=0; i < var_1; ++i) {
  float tmp_1 = -1.7854E-42f;
comp += tmp_1 * var_9 - -1.2149E-36f - var_10 - (+1.7379E34f + var_11);
comp += -1.1339E-44f - +1.2085E34f;
comp = (var_12 * (var_13 * sinf(-1.2139E-23f)));
}
if (comp >= +1.2367E-37f + -0.0f / (+1.7729E15f / (-1.2644E36f + var_14))) {
  comp = fabsf(-0.0f);
}
if (comp <= (+1.4110E34f + -0.0f)) {
  comp += var_15 - var_16;
float tmp_2 = +1.5469E-15f;
comp = tmp_2 - (var_17 + cosf((-0.0f + var_18 / ldexpf(+1.8918E36f / sqrtf(-1.3862E-35f + (-1.5382E29f * -1.3392E35f)), 2))));
comp = (var_19 - (+1.5999E-35f / +1.2273E-8f * (var_20 * +0.0f)));
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
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21);
  cudaDeviceSynchronize();

  return 0;
}
