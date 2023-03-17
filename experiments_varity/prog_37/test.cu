
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float* var_12,float var_13) {
if (comp >= var_3 * tanhf(+0.0f + -1.8035E-43f - powf(var_4 / (+1.8987E36f / ceilf(+0.0f)), -1.3667E-36f - +1.9443E-37f * (var_5 + var_6 / -1.4967E-35f)))) {
  for (int i=0; i < var_1; ++i) {
    comp += (var_7 * +1.7198E-41f);
if (comp >= (var_8 / (var_9 / var_10))) {
  comp += ldexpf(+0.0f + var_11, 2);
}
for (int i=0; i < var_2; ++i) {
  var_12[i] = -1.8572E14f;
comp = var_12[i] - +1.8380E-43f / -1.2608E-36f;
comp = (+1.4079E36f / (var_13 * -1.3413E-35f));
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
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float* tmp_13 = initPointer( atof(argv[13]) );
  float tmp_14 = atof(argv[14]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14);
  cudaDeviceSynchronize();

  return 0;
}
