
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float* var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15) {
for (int i=0; i < var_1; ++i) {
  comp += -1.9765E-42f / (-1.5601E-43f + cosf((+1.7294E36f / (var_4 - var_5))));
for (int i=0; i < var_2; ++i) {
  comp = -1.1387E-37f / var_7 + acosf((+1.3109E-42f - var_8 / (+1.7658E-36f + (-1.9130E36f / (+1.4417E-20f / var_9)))));
comp += +1.9470E35f / var_10 + (var_11 + (var_12 - -1.6893E36f));
var_6[i] = +0.0f;
comp = var_6[i] - (+1.3601E36f + var_13 - powf(+0.0f * (+1.2207E17f + +0.0f + (var_14 / +1.8077E-43f)), var_15 * +1.6241E34f));
}
for (int i=0; i < var_3; ++i) {
  comp += cosf(+1.3550E-18f / -1.8886E7f);
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
  int tmp_4 = atoi(argv[4]);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
