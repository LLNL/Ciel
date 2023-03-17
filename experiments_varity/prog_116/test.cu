
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(double comp, int var_1,double var_2,double var_3,double var_4,double var_5,double var_6,double var_7,double var_8,double var_9,double var_10,double var_11,double var_12,double var_13,double var_14,double var_15,double var_16,double var_17,double var_18,double var_19,double var_20,double var_21,double var_22) {
comp += -1.4106E13f * -0.0f;
comp += (var_2 * +0.0f);
for (int i=0; i < var_1; ++i) {
  float tmp_1 = expf(var_3 * var_4 + +1.0715E-35f + +1.5554E-42f);
comp += tmp_1 / atanf(+1.5513E-36f);
}
if (comp >= var_5 - var_6 / (var_7 * +1.7223E-37f)) {
  comp = var_8 / +1.1415E16f + var_9;
float tmp_2 = log10f(var_10 / (var_11 - var_12 * (+0.0f - -1.5085E35f / var_13)));
comp = tmp_2 / +1.7958E-37f - (var_14 - (var_15 + +1.0455E-36f - -1.9439E34f));
}
if (comp == sqrtf(-1.1082E-15f / var_16 / +1.9922E-44f - var_17 + -1.9692E28f)) {
  comp += fmodf((+1.4765E-42f / acosf((+1.4805E-44f - (var_18 - (var_19 * sqrtf(sinhf(-1.6459E35f))))))), (var_20 - sqrtf((-0.0f / (+1.0954E21f * var_21 + var_22)))));
float tmp_3 = -1.6980E25f;
comp = tmp_3 + floorf(sinhf(+0.0f));
}
   dump(&comp, sizeof(comp));

}

float* initPointer(double v) {
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
  float tmp_23 = atof(argv[23]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23);
  cudaDeviceSynchronize();

  return 0;
}
