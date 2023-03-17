
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float* var_11,float var_12,float var_13,float var_14,float var_15) {
for (int i=0; i < var_1; ++i) {
  if (comp == var_2 * (+1.4715E-42f - -1.3782E35f)) {
    comp = (-1.4090E-41f - var_5 - (var_6 + var_7));
comp = -0.0f - var_8;
comp += var_9 * asinf(-1.4665E17f);
comp = (+0.0f + -1.0400E-35f - (var_10 * ceilf(expf(-1.9179E-35f))));
for (int i=0; i < var_3; ++i) {
  var_11[i] = (var_12 + (var_13 / +1.4589E-36f + (+1.9314E35f - (+1.0494E-43f * +1.7027E-37f))));
float tmp_1 = (var_14 + atanf(+1.3364E-8f));
float tmp_2 = -1.0532E-41f;
comp += tmp_2 - tmp_1 * var_11[i] - (+1.0629E-9f * (+1.4833E-37f - +1.7569E10f));
}
for (int i=0; i < var_4; ++i) {
  comp = -1.0301E-7f * -1.3249E23f * +1.4176E-35f;
comp = (+1.6993E-37f * (+1.0260E-35f * var_15));
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
  int tmp_4 = atoi(argv[4]);
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float* tmp_12 = initPointer( atof(argv[12]) );
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
