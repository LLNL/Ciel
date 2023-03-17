
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33) {
comp = sinf((var_1 * var_2 / coshf(+1.6899E-36f - var_3 - var_4 + var_5)));
comp = +1.2287E-43f + -1.8636E-35f;
comp += (var_6 - (var_7 - -1.9095E5f * (+1.9059E-37f - logf((-1.5088E-36f / fmodf(sinf(var_8 + sqrtf((var_9 + (+0.0f + var_10)))), (var_11 + ldexpf((-1.6471E25f * sqrtf((var_12 + -1.3755E-37f + var_13 * powf((var_14 - -1.9217E35f / var_15 / sinf(-1.4114E-42f)), +0.0f / (-1.5518E13f / var_16 / (var_17 / atanf(+1.0853E29f * +1.2548E-3f))))))), 2))))))));
comp += (+1.3202E-44f - +1.1656E-36f / var_18 - +1.7676E-36f * var_19);
if (comp == var_20 + fmodf((var_21 + +1.1755E-37f + var_22 * (var_23 - acosf(cosf((+0.0f - (-1.1293E36f + -0.0f / +1.7082E-42f)))))), +1.7465E-15f / var_24 * (+1.1625E36f + var_25))) {
  comp = (-1.7123E15f - +1.0857E-44f / var_26 * -1.0677E-41f);
comp += (+1.1663E-20f * (+1.0656E-43f - ceilf(ldexpf((+1.8071E-25f * var_27 * var_28 - (var_29 + -1.1838E-28f * +1.2957E-36f)), 2))));
float tmp_1 = floorf(atan2f(+1.3948E-44f + (var_30 + var_31 / +1.9812E36f), (-0.0f + (-1.9448E-36f * atanf(+1.9803E-35f)))));
comp += tmp_1 - (-1.1810E-43f / (var_32 + sqrtf(-1.3258E35f / -1.0834E36f + (+0.0f - (-1.0444E-35f / var_33)))));
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
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
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
