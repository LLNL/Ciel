
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float* var_9,float var_10,float var_11,float var_12) {
for (int i=0; i < var_1; ++i) {
  if (comp >= (var_2 / -1.0817E-36f)) {
    comp = cosf(-1.9800E34f / (var_5 + ldexpf((-1.8078E-42f * +1.4986E-41f), 2)));
float tmp_1 = -1.4794E-35f;
float tmp_2 = -1.9424E-37f;
comp += tmp_2 / tmp_1 - (-1.3063E-18f - -1.0401E-35f * +1.2162E-43f - var_6);
if (comp >= +0.0f / var_7 / ceilf(+1.0071E-44f)) {
  comp += log10f((+1.3650E-35f + var_8));
}
for (int i=0; i < var_3; ++i) {
  comp += -1.2400E-37f + +1.4328E-42f;
var_9[i] = +1.6281E-15f;
float tmp_3 = +1.6286E36f;
comp = tmp_3 / var_9[i] * -1.9352E-41f * -1.4034E-44f + -1.6408E-13f + var_10 * +1.1786E7f;
}
for (int i=0; i < var_4; ++i) {
  comp = (var_11 + var_12);
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
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float* tmp_10 = initPointer( atof(argv[10]) );
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13);
  cudaDeviceSynchronize();

  return 0;
}
