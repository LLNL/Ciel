
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float* var_10,float var_11,float var_12,float* var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
comp += +1.1797E35f / -1.8345E-18f;
if (comp >= +1.4698E17f + (var_3 / -1.8469E34f)) {
  float tmp_1 = (var_4 / var_5);
comp += tmp_1 * (+0.0f * (var_6 + -1.8055E-42f - -1.8605E-1f));
comp += var_7 / log10f((+1.9604E5f * -1.9015E-41f / (var_8 * (+1.6973E-42f + var_9))));
}
for (int i=0; i < var_1; ++i) {
  var_10[i] = -1.7731E36f;
comp = var_10[i] - var_11 + -1.3626E-44f / var_12;
comp = expf(+0.0f * (+1.2017E36f + +1.7938E36f));
}
for (int i=0; i < var_2; ++i) {
  var_13[i] = var_14 - var_15 - -1.4831E-37f / +1.6308E-36f;
comp += var_13[i] / -0.0f - (-0.0f + var_16);
comp = var_17 - (-1.4859E-41f + var_18 / tanhf(+1.5032E34f));
comp = +0.0f * (var_19 + var_20);
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
  float* tmp_11 = initPointer( atof(argv[11]) );
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float* tmp_14 = initPointer( atof(argv[14]) );
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
