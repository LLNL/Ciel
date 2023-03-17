
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,int var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float* var_26,float* var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33) {
if (comp >= log10f((var_1 - var_2))) {
  if (comp < -1.2261E19f + coshf(var_3 * +0.0f * (var_4 * (-1.4165E-25f * var_5)))) {
    comp += var_7 - (var_8 + var_9 - (-0.0f * -1.2062E23f + +1.4310E-41f));
comp += var_10 + var_11 + (-1.0789E-35f + var_12 - +1.3540E35f - +1.2578E-36f);
if (comp > -1.3189E36f + +1.2720E36f - (var_13 * (-1.6585E36f / var_14 - var_15))) {
  comp += var_16 - (var_17 * (var_18 * acosf((+0.0f / var_19 - -1.2988E-22f / var_20))));
}
if (comp <= (var_21 * -1.9488E-29f * -1.2776E36f)) {
  comp = -0.0f * sinf(+1.4719E26f);
float tmp_1 = logf(+1.3238E-44f);
comp = tmp_1 + +1.3141E35f + (var_22 / (var_23 - -0.0f + (var_24 * var_25)));
}
for (int i=0; i < var_6; ++i) {
  var_26[i] = +0.0f;
float tmp_2 = +1.1754E-17f;
var_27[i] = (var_28 - log10f(var_29 - (-1.3263E-36f - (var_30 / +1.1926E-42f))));
comp = var_27[i] / tmp_2 * var_26[i] / (var_31 - (+1.1612E-36f / (var_32 * var_33 + (-1.0845E-36f * -1.6945E-44f))));
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
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float* tmp_27 = initPointer( atof(argv[27]) );
  float* tmp_28 = initPointer( atof(argv[28]) );
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);
  float tmp_31 = atof(argv[31]);
  float tmp_32 = atof(argv[32]);
  float tmp_33 = atof(argv[33]);
  float tmp_34 = atof(argv[34]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34);
  cudaDeviceSynchronize();

  return 0;
}
