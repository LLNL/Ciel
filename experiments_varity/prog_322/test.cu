
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float* var_13,float* var_14,float var_15,float var_16,float var_17,float var_18,float* var_19,float var_20,float var_21,float var_22) {
comp = +1.9693E-12f * (-1.6217E-27f - var_3);
float tmp_1 = -1.1476E20f;
float tmp_2 = -1.4052E17f;
comp = tmp_2 - tmp_1 + atan2f(+1.0054E35f, -1.1269E16f);
if (comp >= (var_4 / +0.0f - -1.2436E25f)) {
  comp += (+1.3861E-17f / var_5 - var_6);
comp += (+1.4150E35f + +1.4644E26f - (var_7 - (var_8 - acosf(var_9 + var_10))));
float tmp_3 = -1.5285E35f;
comp += tmp_3 * var_11 / var_12;
}
for (int i=0; i < var_1; ++i) {
  var_13[i] = logf((+1.9498E-22f - (var_15 - (+0.0f - -0.0f + (+1.0670E34f - var_16)))));
var_14[i] = +0.0f;
comp += var_14[i] - var_13[i] - var_17 * coshf((var_18 - +1.3579E-36f + +1.9518E-43f));
}
for (int i=0; i < var_2; ++i) {
  var_19[i] = +1.0360E-42f;
comp += var_19[i] / var_20 + var_21 / (var_22 + -1.4828E-36f);
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
  float* tmp_14 = initPointer( atof(argv[14]) );
  float* tmp_15 = initPointer( atof(argv[15]) );
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float* tmp_20 = initPointer( atof(argv[20]) );
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23);
  cudaDeviceSynchronize();

  return 0;
}
