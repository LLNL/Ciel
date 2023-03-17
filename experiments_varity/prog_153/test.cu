
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33,float var_34,float var_35,float var_36,float var_37) {
for (int i=0; i < var_1; ++i) {
  comp = var_3 / (var_4 - (-1.6661E-42f + +0.0f));
float tmp_1 = var_5 - var_6;
float tmp_2 = +1.1214E-42f;
comp = tmp_2 / tmp_1 - +0.0f / sqrtf(var_7 * (-0.0f - (+1.2595E-41f - atan2f(var_8 / (var_9 + ldexpf(ldexpf(-0.0f, 2), 2)), ceilf(var_10 + var_11 - var_12 + var_13)))));
if (comp == (+1.8695E4f / var_14)) {
  float tmp_3 = log10f(var_15 * (+1.5900E35f / (-1.4083E-37f - powf((var_16 - +1.0132E11f * var_17 * ldexpf(acosf((-1.5411E36f * atan2f(-1.5994E-35f / var_18 / var_19 - +1.5974E-44f - (var_20 / var_21), sqrtf(expf((-1.0387E-13f / (+1.1526E-36f / (+1.3835E-35f * (+0.0f + ceilf((var_22 / (+1.1241E20f + var_23 - var_24)))))))))))), 2)), (var_25 * (var_26 / +1.8262E-42f - -1.2852E8f * var_27))))));
float tmp_4 = +1.0357E22f;
comp += tmp_4 + tmp_3 + (+1.3414E12f * (+1.2422E29f * var_28 + var_29));
comp += (-1.5770E-35f * var_30);
}
for (int i=0; i < var_2; ++i) {
  float tmp_5 = (var_31 - (var_32 - var_33 / expf(-1.3282E-35f * -1.3221E-36f)));
comp = tmp_5 + (var_34 / -1.7788E-44f + (+1.3019E35f + -0.0f - var_35 + var_36));
comp += -1.3912E35f + var_37 * -1.1422E17f;
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
  float tmp_35 = atof(argv[35]);
  float tmp_36 = atof(argv[36]);
  float tmp_37 = atof(argv[37]);
  float tmp_38 = atof(argv[38]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34,tmp_35,tmp_36,tmp_37,tmp_38);
  cudaDeviceSynchronize();

  return 0;
}
