
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = -1.5914E-43f;
float tmp_2 = (-1.3808E-35f / ceilf((-1.0851E-37f * log10f((-1.0437E36f - (var_3 - (-1.9410E-41f * -1.4893E7f + var_4 / +1.7362E-35f)))))));
float tmp_3 = (-0.0f / +1.4785E-8f + var_5);
comp += tmp_3 - tmp_2 * tmp_1 / var_6 + -1.3380E-35f;
for (int i=0; i < var_2; ++i) {
  comp = var_7 * var_8;
}
if (comp == -0.0f / cosf(+1.0663E-37f + -1.8452E-42f - var_9 + logf(+1.5149E-36f / -1.0874E19f * logf(+1.7400E13f)))) {
  float tmp_4 = -1.3328E-36f;
float tmp_5 = floorf((var_10 + (var_11 * (var_12 - ldexpf((+1.2927E-35f - (var_13 - (var_14 * +1.4363E-42f + var_15))), 2)))));
comp += tmp_5 / tmp_4 / var_16 * (-1.9099E36f + var_17);
}
if (comp >= +1.7018E-44f + +1.3527E-37f) {
  comp += +1.7350E-42f + expf(tanhf((var_18 - +1.0340E-41f)));
comp += atan2f((+0.0f / (var_19 + var_20 - +1.1250E34f / floorf(+1.6097E36f / fmodf(+1.2477E-8f, sqrtf(atan2f(+1.1544E-43f / +1.5844E-43f, -0.0f)))))), (+1.5745E-14f * floorf((+1.8944E-43f + -1.6229E-35f - var_21 - var_22))));
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
