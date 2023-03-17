
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,int var_7,int var_8,int var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float* var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30) {
if (comp >= (-1.6656E23f - (var_2 + +1.8501E-43f * (-1.6050E-35f / (-1.3931E-35f - var_3))))) {
  if (comp > -0.0f - (-0.0f * var_4 + var_5)) {
    if (comp < (+1.7990E15f + var_6)) {
      for (int i=0; i < var_1; ++i) {
        comp = -1.5762E-36f / var_10 + (var_11 - var_12);
comp += (var_13 / var_14 / -1.4057E36f);
for (int i=0; i < var_7; ++i) {
  float tmp_1 = (+1.1568E-37f + ldexpf(-1.9930E-35f * sinf((+1.1203E34f + (-1.6866E-43f + (var_15 / var_16)))), 2));
comp += tmp_1 / ldexpf(-1.5442E-36f / -1.6635E34f - var_17, 2);
}
for (int i=0; i < var_8; ++i) {
  var_18[i] = var_19 / coshf(tanhf(ceilf(var_20 - var_21)));
float tmp_2 = logf(var_22 / logf(-1.6411E27f + var_23 - -1.5443E4f));
comp = tmp_2 * var_18[i] - -0.0f + var_24 / +1.5382E16f;
comp = acosf(var_25 - +1.4894E35f / +1.1725E-35f);
}
for (int i=0; i < var_9; ++i) {
  comp += sqrtf(var_26 - logf((-1.4186E-36f * (var_27 - +1.9571E-16f / (var_28 / (var_29 - var_30))))));
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
  float tmp_3 = atof(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  int tmp_8 = atoi(argv[8]);
  int tmp_9 = atoi(argv[9]);
  int tmp_10 = atoi(argv[10]);
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
  float tmp_29 = atof(argv[29]);
  float tmp_30 = atof(argv[30]);
  float tmp_31 = atof(argv[31]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31);
  cudaDeviceSynchronize();

  return 0;
}
