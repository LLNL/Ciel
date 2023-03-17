
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,int var_3,float var_4,float var_5,float var_6,float* var_7,float* var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22) {
if (comp <= var_1 + var_2 + -0.0f) {
  comp = sinf((+1.4539E-41f * (var_4 + var_5 * (+0.0f * var_6))));
for (int i=0; i < var_3; ++i) {
  var_7[i] = cosf((var_9 * sinf(-1.0267E26f / +1.2468E23f)));
var_8[i] = -1.2872E-42f;
comp += var_8[i] * var_7[i] - -0.0f - var_10;
}
if (comp == (var_11 * logf(+1.6407E19f))) {
  float tmp_1 = (var_12 / var_13 - sqrtf((+1.0377E-37f - +1.5482E-44f + -1.5813E-35f * (-0.0f - -0.0f))));
float tmp_2 = (-1.6053E26f * +1.1100E-37f - ceilf(+1.9220E36f / ceilf(var_14 + (+1.6144E-36f / var_15 * (-1.8990E34f / (+1.5194E24f - -0.0f))))));
float tmp_3 = +0.0f;
comp = tmp_3 / tmp_2 / tmp_1 / var_16 / var_17 / var_18 + -1.0775E35f / sinhf(var_19 * -1.0626E-35f);
}
if (comp < var_20 * -1.6531E-42f * -0.0f) {
  float tmp_4 = -0.0f;
comp = tmp_4 - +0.0f / (var_21 / -1.5219E-44f - var_22);
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
  float tmp_2 = atof(argv[2]);
  float tmp_3 = atof(argv[3]);
  int tmp_4 = atoi(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float* tmp_8 = initPointer( atof(argv[8]) );
  float* tmp_9 = initPointer( atof(argv[9]) );
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
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23);
  cudaDeviceSynchronize();

  return 0;
}
