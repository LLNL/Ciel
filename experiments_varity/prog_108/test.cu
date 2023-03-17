
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,int var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
if (comp < var_1 * (+1.2872E-36f + (-1.0993E-43f - (var_2 * sinhf((+1.2431E35f * +1.0740E35f - (-0.0f / (var_3 - var_4 + var_5)))))))) {
  float tmp_1 = +1.0345E-44f;
comp = tmp_1 + tanhf(var_7 * sinf(coshf(+1.5656E-24f - (+1.8390E-35f * -1.2912E16f - -1.9283E-44f))));
comp = (var_8 + ceilf(var_9 - -0.0f));
comp = (+0.0f / (-1.4405E-43f + var_10 * var_11 * +1.5392E-36f));
for (int i=0; i < var_6; ++i) {
  comp += +1.7973E-14f / +1.0895E36f / -1.6782E-3f / -1.2084E-36f;
comp += fabsf(var_12 * var_13 / -1.7342E-43f + fmodf((var_14 * -0.0f / (var_15 / var_16)), +0.0f + var_17));
comp += +1.3136E36f + ldexpf(+0.0f + var_18 * +1.1474E-37f - -1.7400E17f, 2);
}
if (comp < (-1.3745E-26f + (-1.6333E-37f - var_19))) {
  comp = -1.9237E6f * var_20 - -1.9746E-37f;
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
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  int tmp_7 = atoi(argv[7]);
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
