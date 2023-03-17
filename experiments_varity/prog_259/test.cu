
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float* var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    float tmp_1 = +1.1019E35f;
float tmp_2 = var_4 + +0.0f + +1.6033E-3f / fmodf(var_5 - +1.7091E-37f, -1.2257E-16f - -1.3731E-37f / var_6 / var_7 * (-0.0f / var_8));
comp += tmp_2 * tmp_1 / (-1.2086E36f * +1.0334E-37f);
comp += (var_9 / (-1.6171E-6f * var_10));
if (comp == var_11 + var_12 * var_13) {
  float tmp_3 = var_14 * var_15;
comp = tmp_3 - -1.5535E-6f - -1.7337E-12f;
comp += (var_16 - var_17 - var_18);
comp = (+0.0f - var_19);
}
for (int i=0; i < var_3; ++i) {
  float tmp_4 = coshf((-1.1252E-35f * var_21 / +0.0f - var_22 * (+0.0f * +1.6641E-44f)));
var_20[i] = -1.9894E-20f / atanf(+0.0f * (+1.2795E34f + +0.0f));
comp = var_20[i] + tmp_4 - tanhf((var_23 / -1.5336E-36f / var_24 / -1.0568E-43f));
comp = -1.1037E-42f / (+0.0f - var_25 + var_26);
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
  int tmp_3 = atoi(argv[3]);
  int tmp_4 = atoi(argv[4]);
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
  float* tmp_21 = initPointer( atof(argv[21]) );
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27);
  cudaDeviceSynchronize();

  return 0;
}
