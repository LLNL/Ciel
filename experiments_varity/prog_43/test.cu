
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22) {
for (int i=0; i < var_1; ++i) {
  float tmp_1 = -0.0f;
comp = tmp_1 + (-1.7002E-43f + -1.4704E34f - (-0.0f / floorf(var_2 + var_3)));
float tmp_2 = -0.0f;
comp += tmp_2 + (+0.0f + (-1.1545E-36f / (+1.2037E21f / var_4)));
if (comp > powf((-1.9519E-43f - +1.7762E-43f * (+0.0f * (+1.3483E34f / var_5))), -1.0702E-37f)) {
  comp += (var_6 + var_7 / var_8);
}
if (comp == -0.0f * +1.1074E-26f + (-1.2647E-43f - (var_9 + var_10))) {
  comp = var_11 + +0.0f + -1.8316E-36f - -1.1506E16f;
comp = -0.0f - powf(+1.0406E1f - (+1.9075E-35f + (var_12 * -1.3482E-35f - -1.3764E35f * -0.0f)), var_13 + sinhf(-0.0f));
}
if (comp >= var_14 / (+1.5558E-37f + var_15 * var_16)) {
  comp += (var_17 * var_18 / powf(-1.2662E-42f, -1.6396E-10f * var_19));
comp = (var_20 + +1.3093E36f);
comp = (-1.6917E-43f + fabsf(log10f((+1.2191E-37f / (var_21 / +0.0f / var_22)))));
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
