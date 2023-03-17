
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
if (comp < var_2 / var_3 - var_4 + fabsf(+1.6968E21f)) {
  for (int i=0; i < var_1; ++i) {
    float tmp_1 = +0.0f - (var_6 / var_7 * -1.4756E-43f - powf(fmodf(-1.6327E-43f, (-1.1981E-42f / (-1.7529E-37f + +0.0f))), asinf(+1.7393E20f)));
comp += tmp_1 / -1.3600E35f + +1.6405E-35f + cosf((var_8 / (+1.7154E-43f - (-1.4625E9f - var_9 / var_10))));
if (comp >= (+1.5578E-43f - logf(log10f(-1.1290E23f)))) {
  comp = var_11 * var_12 - (+1.5927E8f + +0.0f);
}
for (int i=0; i < var_5; ++i) {
  comp = +1.5094E36f + (var_13 + ldexpf(tanhf(+1.4825E2f + var_14 * (var_15 * fmodf(powf(tanhf(fmodf((-1.9049E-35f / var_16), var_17 - var_18 + +1.5543E-42f)), (+1.3079E-36f * (-1.3300E36f / floorf(-1.6612E35f)))), atan2f(ldexpf(+1.1272E-41f, 2), logf(var_19 * -1.9125E-44f - var_20))))), 2));
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
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  int tmp_6 = atoi(argv[6]);
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
