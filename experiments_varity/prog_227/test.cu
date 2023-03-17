
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float* var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float* var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
if (comp <= (var_3 - +0.0f)) {
  for (int i=0; i < var_1; ++i) {
    for (int i=0; i < var_2; ++i) {
      var_4[i] = +1.7374E-42f;
comp += var_4[i] / var_6 + -0.0f;
if (comp <= (var_7 * (+1.5845E-35f - floorf(fmodf(-1.1767E35f - +1.5610E-13f / -1.7831E-42f, (var_8 - var_9 / +1.1565E-42f)))))) {
  float tmp_1 = -1.0796E-42f;
comp = tmp_1 - floorf(-1.1935E-43f);
float tmp_2 = -1.5271E34f;
comp += tmp_2 * (-1.3054E36f - var_10 / ceilf((+1.0139E-27f - +1.4960E-36f)));
}
for (int i=0; i < var_5; ++i) {
  comp += expf((-1.6751E-18f + (-1.0289E36f - (var_12 + (-1.4354E36f * (+1.0830E36f * +1.8676E27f))))));
var_11[i] = var_13 - var_14 + (var_15 + var_16);
float tmp_3 = +1.6604E-35f;
comp = tmp_3 * var_11[i] + +0.0f - +1.0079E-24f;
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
  float* tmp_5 = initPointer( atof(argv[5]) );
  int tmp_6 = atoi(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float* tmp_12 = initPointer( atof(argv[12]) );
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
