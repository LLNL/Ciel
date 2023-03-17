
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float* var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float var_23,float var_24) {
comp += -1.7064E-44f - var_3 - +1.0572E-42f - var_4;
for (int i=0; i < var_1; ++i) {
  float tmp_1 = (var_6 * +1.1598E-37f / (var_7 / floorf(logf((var_8 / -1.9263E-36f / var_9 * +1.7142E36f + var_10)))));
var_5[i] = log10f(tanhf(-0.0f));
float tmp_2 = -1.2157E34f;
comp = tmp_2 * var_5[i] / tmp_1 / var_11 / acosf(var_12 / +1.8103E-3f / (+0.0f * +0.0f));
}
for (int i=0; i < var_2; ++i) {
  comp = (var_13 + +1.9403E-41f);
}
if (comp >= sqrtf(var_14 + var_15 * +1.6571E34f)) {
  float tmp_3 = +1.6163E-35f * var_16;
float tmp_4 = (+1.8482E27f / var_17 * +1.0044E-43f);
comp = tmp_4 / tmp_3 * powf(coshf((+1.0795E-9f + (var_18 - +1.7313E21f / coshf(var_19 - var_20 / floorf(logf((-1.2496E-28f / -1.8555E22f * var_21))))))), coshf((+0.0f / var_22 / (var_23 * (-0.0f * (var_24 * +1.6037E-35f))))));
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
  float* tmp_6 = initPointer( atof(argv[6]) );
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
