
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float* var_16,float* var_17,float* var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24) {
float tmp_1 = +1.6090E1f;
float tmp_2 = -0.0f;
comp = tmp_2 * tmp_1 * (-1.3900E-37f - (var_3 * -0.0f));
for (int i=0; i < var_1; ++i) {
  float tmp_3 = -1.6793E21f;
comp += tmp_3 * (var_4 + var_5 * floorf(cosf(var_6 / sqrtf(var_7 - var_8))));
}
if (comp <= (var_9 + var_10 + (var_11 / (+1.8532E4f + +1.9727E15f)))) {
  comp += var_12 - -1.4051E-35f + var_13 / (-1.4038E-28f - var_14);
float tmp_4 = +1.2228E-43f;
comp = tmp_4 / -0.0f - var_15;
}
for (int i=0; i < var_2; ++i) {
  float tmp_5 = -0.0f;
  var_16[i] = (var_19 - var_20 + -1.3471E-35f);
var_17[i] = (-0.0f - (var_21 + +1.8118E-23f + -1.6733E-16f));
var_18[i] = (var_22 - var_23 + -1.6458E4f);
tmp_5 = var_18[i];
comp = tmp_5 / var_17[i] - var_16[i] / tanhf(var_24 + +1.3433E35f);
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
  float* tmp_17 = initPointer( atof(argv[17]) );
  float* tmp_18 = initPointer( atof(argv[18]) );
  float* tmp_19 = initPointer( atof(argv[19]) );
  float tmp_20 = atof(argv[20]);
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25);
  cudaDeviceSynchronize();

  return 0;
}
