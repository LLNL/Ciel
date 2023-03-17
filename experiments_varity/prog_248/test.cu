
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24) {
comp += cosf((-1.7576E-30f + -1.9558E-37f * (-1.0797E-44f - var_2 * -1.5780E5f)));
for (int i=0; i < var_1; ++i) {
  comp = var_3 + (-1.5776E-42f / +0.0f + acosf(asinf(-1.4089E36f)));
comp += asinf(sinhf((-0.0f * +0.0f - (var_4 + -1.2916E-43f - var_5))));
comp = +1.2099E-35f + var_6 / (var_7 - -1.1441E-42f * sinhf(+1.2249E1f));
}
if (comp <= (-0.0f - var_8)) {
  comp = (var_9 / (var_10 + var_11 + var_12));
float tmp_1 = powf(var_13 - -1.3566E15f * var_14, ldexpf(+0.0f, 2));
comp += tmp_1 * fmodf((-1.2780E-29f + -1.3688E-35f / (var_15 + -1.3110E34f + -1.8922E-35f)), (-1.3659E-41f + var_16));
}
if (comp == atan2f((-1.3190E34f + -1.3193E9f + var_17 - (+1.3294E-35f / var_18 + +1.8826E-42f)), (-1.9068E34f + (+1.5156E36f + -1.7177E35f + var_19)))) {
  comp += +1.6347E-43f * var_20 - -1.7625E-37f + powf((-1.9462E-13f + var_21 - +1.8158E-42f / (-1.5474E34f + -1.0966E-42f + var_22)), var_23 / var_24 * +1.4382E-36f + sinhf((+0.0f + +1.4582E-44f)));
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
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25);
  cudaDeviceSynchronize();

  return 0;
}
