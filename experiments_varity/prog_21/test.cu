
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float* var_19,float* var_20,float var_21,float var_22,float var_23,float var_24,float var_25,float var_26,float var_27,float var_28,float var_29,float var_30,float var_31,float var_32,float var_33,float var_34,float var_35,float var_36,float var_37,float var_38,float var_39,float var_40,float var_41,float var_42,float var_43,float var_44,float var_45,float var_46,float var_47) {
float tmp_1 = (+1.7017E-35f - (var_2 - sinf(var_3 / var_4)));
comp += tmp_1 * var_5 / (var_6 + var_7 - floorf(cosf(var_8 / -1.8038E-20f)));
comp += var_9 / (var_10 * -1.7062E35f + var_11 / var_12 * var_13);
comp = var_14 + (-1.0880E-36f * var_15 - (var_16 / var_17 * var_18));
for (int i=0; i < var_1; ++i) {
  var_19[i] = +1.1136E-44f;
comp += var_19[i] + fmodf((+1.3711E35f - tanhf(-1.7783E-30f * var_21)), -1.8809E35f * +1.5638E-43f / (+1.7277E27f + (-1.7914E-35f / -1.1059E-43f)));
var_20[i] = (+1.5688E23f - var_22 / logf(powf(fmodf(+0.0f, (-1.0794E-35f * logf((var_23 * (var_24 / ldexpf(+1.1459E-3f / var_25 - +0.0f, 2)))))), var_26 / (-1.0921E34f * +1.3476E-37f + ceilf((+1.1791E34f * atan2f(cosf(var_27 + var_28), +1.4517E27f)))))));
comp = var_20[i] * (+1.4247E-22f * atanf((-0.0f * +1.7139E-43f)));
}
if (comp == atanf(-1.6008E1f)) {
  float tmp_2 = (+1.1075E35f - atan2f(cosf((+0.0f / asinf(-1.3512E23f + var_29))), var_30 - log10f((+1.2994E-36f * -1.8890E-12f))));
comp += tmp_2 + var_31 / (var_32 - +1.1577E-41f);
comp = var_33 / +1.8852E35f - (var_34 / var_35 * +1.9336E-43f - var_36);
}
if (comp >= var_37 + (var_38 + (+1.4578E-41f / (-1.0898E-37f * var_39)))) {
  float tmp_3 = +1.4485E3f;
float tmp_4 = ldexpf(expf(var_40 - -1.3678E-44f + var_41 + var_42), 2);
float tmp_5 = (+0.0f * +1.6230E-44f);
comp += tmp_5 / tmp_4 + tmp_3 * -1.0934E35f + var_43 * (+1.6037E34f * expf(-1.5607E-37f * var_44 + var_45 * var_46 + var_47));
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
  float* tmp_20 = initPointer( atof(argv[20]) );
  float* tmp_21 = initPointer( atof(argv[21]) );
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
  float tmp_39 = atof(argv[39]);
  float tmp_40 = atof(argv[40]);
  float tmp_41 = atof(argv[41]);
  float tmp_42 = atof(argv[42]);
  float tmp_43 = atof(argv[43]);
  float tmp_44 = atof(argv[44]);
  float tmp_45 = atof(argv[45]);
  float tmp_46 = atof(argv[46]);
  float tmp_47 = atof(argv[47]);
  float tmp_48 = atof(argv[48]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29,tmp_30,tmp_31,tmp_32,tmp_33,tmp_34,tmp_35,tmp_36,tmp_37,tmp_38,tmp_39,tmp_40,tmp_41,tmp_42,tmp_43,tmp_44,tmp_45,tmp_46,tmp_47,tmp_48);
  cudaDeviceSynchronize();

  return 0;
}
