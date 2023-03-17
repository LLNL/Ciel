
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float* var_8,int var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float* var_19,float var_20,float var_21,float var_22,float var_23) {
if (comp <= (var_2 / atanf((var_3 - var_4)))) {
  if (comp < (var_5 - -0.0f * var_6 - var_7)) {
    for (int i=0; i < var_1; ++i) {
      var_8[i] = -1.3654E-22f * var_10;
comp += var_8[i] + ceilf(-1.8553E-19f + sinhf(-1.6889E14f - (var_11 + (+1.8238E-2f / var_12))));
comp += (var_13 * cosf((var_14 + -1.3239E1f)));
if (comp > (+0.0f - (var_15 - -1.5815E36f))) {
  comp += -1.8948E-42f * (var_16 - (var_17 / sinhf(sinf(sinhf(-0.0f / +1.9691E35f - -1.6180E-15f)))));
float tmp_1 = +1.8446E34f;
comp = tmp_1 - -1.7162E-28f / -1.9701E-43f / (var_18 - tanhf(log10f(-0.0f)));
comp = acosf(+0.0f);
}
for (int i=0; i < var_9; ++i) {
  var_19[i] = -1.3559E-41f;
float tmp_2 = -1.6030E34f;
comp += tmp_2 + var_19[i] / var_20 + tanhf((var_21 / var_22 / +1.9554E-35f + var_23));
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
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float* tmp_9 = initPointer( atof(argv[9]) );
  int tmp_10 = atoi(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float* tmp_20 = initPointer( atof(argv[20]) );
  float tmp_21 = atof(argv[21]);
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24);
  cudaDeviceSynchronize();

  return 0;
}
