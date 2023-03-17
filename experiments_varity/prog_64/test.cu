
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,int var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float* var_14,float* var_15,float var_16,float var_17,float var_18,float var_19,float* var_20,float var_21,float var_22,float var_23,float var_24,float var_25) {
if (comp < +0.0f * var_1) {
  float tmp_1 = -1.8671E-35f;
comp += tmp_1 / (-1.3120E-37f / cosf((var_5 - -0.0f)));
comp = atanf(+0.0f);
comp = (+0.0f - -1.6877E-22f - (-1.7781E4f + var_6 / var_7));
for (int i=0; i < var_2; ++i) {
  float tmp_2 = +0.0f;
comp += tmp_2 * var_8 * var_9 - var_10 + var_11;
comp = +1.4191E8f - (var_12 * (-1.7829E-35f - (+1.0138E35f * var_13)));
}
for (int i=0; i < var_3; ++i) {
  float tmp_3 = (+1.5109E36f + expf(+1.8408E36f + (-1.8180E-44f - (var_16 * (+1.9724E36f / var_17)))));
var_14[i] = -1.2210E-35f;
var_15[i] = +1.4652E34f;
comp = var_15[i] / var_14[i] - tmp_3 + powf(+1.3100E-35f - -0.0f / +1.6113E-36f / (var_18 + (+1.8844E7f / +1.7618E-42f)), -1.0730E-9f / var_19);
}
for (int i=0; i < var_4; ++i) {
  comp = -1.9438E34f / (-1.9796E34f * +1.2381E-27f / var_21);
var_20[i] = -1.5665E35f;
float tmp_4 = var_22 * -0.0f + var_23;
comp += tmp_4 * var_20[i] * fabsf(-1.5118E-2f * coshf((var_24 * +1.0091E36f - (var_25 * sinf(tanhf(-0.0f))))));
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
  int tmp_3 = atoi(argv[3]);
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float* tmp_15 = initPointer( atof(argv[15]) );
  float* tmp_16 = initPointer( atof(argv[16]) );
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);
  float tmp_19 = atof(argv[19]);
  float tmp_20 = atof(argv[20]);
  float* tmp_21 = initPointer( atof(argv[21]) );
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26);
  cudaDeviceSynchronize();

  return 0;
}
