
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float* var_5,float* var_6,float* var_7,float var_8,float var_9,float var_10,float* var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
comp = (+1.0268E34f * +1.6547E9f * (var_3 - var_4));
for (int i=0; i < var_1; ++i) {
  var_5[i] = -1.5800E34f;
var_6[i] = sinf((var_8 + (var_9 - cosf(-1.8832E-43f))));
var_7[i] = +1.8731E34f;
comp += var_7[i] + var_6[i] * var_5[i] * +1.5318E-35f + (-1.0675E-37f - var_10);
}
for (int i=0; i < var_2; ++i) {
  var_11[i] = -0.0f;
float tmp_1 = -1.9597E36f;
comp = tmp_1 * var_11[i] - (var_12 / (-1.4935E-36f * (var_13 * +1.5838E-37f)));
}
if (comp >= (var_14 * (-1.5700E-26f * +1.2359E-42f + cosf((-1.2237E-37f * var_15 / +1.8914E-44f / var_16))))) {
  float tmp_2 = +1.2200E35f;
comp += tmp_2 - (-1.8775E-41f * (-0.0f / +1.9521E34f / -1.7387E34f));
comp = var_17 * logf(var_18 / (-1.3151E-37f * (var_19 * var_20 * +1.4525E-29f)));
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
  float* tmp_6 = initPointer( atof(argv[6]) );
  float* tmp_7 = initPointer( atof(argv[7]) );
  float* tmp_8 = initPointer( atof(argv[8]) );
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float* tmp_12 = initPointer( atof(argv[12]) );
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
