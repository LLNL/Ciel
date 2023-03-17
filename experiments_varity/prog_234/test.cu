
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,int var_4,int var_5,int var_6,float var_7,float var_8,float* var_9,float* var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    for (int i=0; i < var_3; ++i) {
      for (int i=0; i < var_4; ++i) {
        float tmp_1 = -0.0f;
comp += tmp_1 + +1.7959E5f - -0.0f;
comp += -1.4499E34f + var_7 - coshf(+1.2568E-11f * (+1.5309E-41f - var_8));
for (int i=0; i < var_5; ++i) {
  var_9[i] = atan2f(-1.3134E-27f - (+1.0253E-36f / -0.0f * var_11 + var_12), var_13 - (+1.5368E35f - var_14 + -1.3070E-27f));
var_10[i] = var_15 + (-1.7340E28f / (-1.8622E35f * (-1.3255E36f - +1.6146E-37f)));
comp += var_10[i] - var_9[i] - floorf((-1.8950E8f * (+1.8632E34f / var_16)));
comp = -1.4070E-42f - (-1.1692E-42f * +1.1446E-35f * (+0.0f + (var_17 - -1.3687E34f)));
}
for (int i=0; i < var_6; ++i) {
  float tmp_2 = +1.2110E-3f;
comp = tmp_2 + -1.9469E-14f / sqrtf(expf(+1.7079E35f));
comp += +1.5617E-41f + var_18 / (var_19 / (+1.3114E-44f + var_20));
comp += (var_21 * -0.0f + (var_22 * (var_23 - +1.9176E-41f / +1.8814E35f)));
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
  int tmp_5 = atoi(argv[5]);
  int tmp_6 = atoi(argv[6]);
  int tmp_7 = atoi(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float* tmp_10 = initPointer( atof(argv[10]) );
  float* tmp_11 = initPointer( atof(argv[11]) );
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24);
  cudaDeviceSynchronize();

  return 0;
}
