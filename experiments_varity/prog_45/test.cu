
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21) {
comp = var_1 + -1.0156E-36f * var_2;
if (comp < (var_3 * (-0.0f / var_4))) {
  float tmp_1 = +1.3948E1f + +1.7148E35f * +1.4966E-1f;
comp += tmp_1 + (var_5 * sqrtf((var_6 - (var_7 * -1.3162E-42f))));
comp += +1.2144E-41f - (var_8 + -1.9306E-9f + var_9);
}
if (comp > -0.0f * (-1.2006E34f + var_10)) {
  float tmp_2 = +1.5972E34f;
float tmp_3 = var_11 - +1.4203E-42f / cosf(var_12 - fmodf(-1.6689E-43f - var_13, var_14 + sqrtf(+0.0f)));
comp = tmp_3 * tmp_2 + -0.0f - var_15 / (+1.4749E-44f + -1.5832E-43f);
comp = (var_16 / atan2f(var_17 / var_18 / ceilf((var_19 / (+1.8022E34f + var_20 / -1.6589E-37f + var_21))), (+0.0f / +1.7854E-37f)));
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
  float tmp_22 = atof(argv[22]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22);
  cudaDeviceSynchronize();

  return 0;
}
