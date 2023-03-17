
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    if (comp >= (+0.0f - var_3 + fmodf(-1.0742E36f, (var_4 / (+1.4778E-41f * -0.0f))))) {
      comp += (+1.9408E36f + (var_5 + (-1.8291E20f + var_6 - +1.9175E-44f)));
comp = cosf((+0.0f - (-1.3183E17f + +0.0f)));
if (comp == (-1.6748E-44f - var_7)) {
  comp = var_8 / +1.8234E-35f;
}
if (comp >= sinhf(var_9 * (var_10 - asinf(var_11 + +1.2600E36f - (var_12 + (-1.1193E-11f * +1.1195E-42f)))))) {
  comp = (var_13 * (+1.7241E34f + (var_14 * +1.5914E8f)));
comp = -1.2489E11f - (+1.6243E-42f - var_15);
}
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
  int tmp_3 = atoi(argv[3]);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
