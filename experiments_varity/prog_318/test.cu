
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,int var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    for (int i=0; i < var_3; ++i) {
      if (comp == asinf(+1.6052E-29f * (var_4 - (+1.3418E-44f * -1.1849E-36f)))) {
        float tmp_1 = +1.4940E-23f;
float tmp_2 = -1.6240E35f + -1.2672E-41f + +1.0623E34f + atan2f(logf(var_6 * -0.0f), (-1.4919E-42f * atan2f((-1.9619E-37f * (-1.6127E-37f + acosf(var_7 * -1.0424E-41f / -1.8312E-36f * var_8))), var_9 * (-1.5333E-43f * var_10 / powf(var_11 - coshf((var_12 - coshf(var_13 / -1.9055E20f))), -1.0315E9f)))));
comp = tmp_2 * tmp_1 - +1.6798E36f * (+1.1643E34f - (var_14 * +1.4241E36f * (var_15 + var_16)));
comp += var_17 / floorf(+0.0f);
for (int i=0; i < var_5; ++i) {
  comp += +1.6689E-43f - asinf(-1.4086E35f / +0.0f * var_18 + var_19);
}
if (comp == (+1.3292E34f - var_20 * (-1.9025E-42f - var_21))) {
  comp = +1.9010E19f * var_22 * -1.4243E-5f * tanhf((-1.4812E-35f * +1.5328E36f));
}
}
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
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23);
  cudaDeviceSynchronize();

  return 0;
}
