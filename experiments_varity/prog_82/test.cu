
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float* var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27) {
if (comp <= (-0.0f * sinhf((+1.5104E-35f + var_3)))) {
  float tmp_1 = (var_4 - var_5 * var_6 - var_7);
comp = tmp_1 - (+1.0667E-36f * var_8);
if (comp > var_9 - var_10 + (-1.1912E-37f - var_11)) {
  comp = cosf((-1.5333E-37f * -0.0f));
comp += -1.2488E-41f * (-1.2186E-43f - (var_12 * (-1.2041E-42f - var_13 / -1.1994E-44f)));
comp += +1.4314E-43f / +1.2993E-28f + +1.5299E-15f - (var_14 - log10f((var_15 - +1.8415E-37f * -1.3874E-44f - +1.5091E35f)));
comp += -0.0f + -1.8204E-37f;
}
for (int i=0; i < var_1; ++i) {
  comp = var_16 - var_17 + (-1.4232E34f + (-1.3987E-44f * -0.0f * +0.0f));
}
for (int i=0; i < var_2; ++i) {
  float tmp_2 = +1.1386E-35f + var_19 - +0.0f + var_20 / -1.2414E-37f * +1.5185E-43f;
comp = tmp_2 / (var_21 * (-1.4031E13f + var_22 / (var_23 + var_24)));
var_18[i] = (var_25 / (-1.9526E-24f / +1.8340E-4f));
comp += var_18[i] / (var_26 - (var_27 - -1.7063E-37f * +1.9946E-44f));
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
  float* tmp_19 = initPointer( atof(argv[19]) );
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28);
  cudaDeviceSynchronize();

  return 0;
}
