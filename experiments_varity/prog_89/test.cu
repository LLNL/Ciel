
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14) {
comp = (-1.4149E17f / -1.2899E-8f);
for (int i=0; i < var_1; ++i) {
  float tmp_1 = (var_2 - (var_3 / -1.9107E-14f + +0.0f - (var_4 + +1.8370E-25f)));
comp += tmp_1 - logf(log10f((-1.7442E36f / var_5 * (var_6 * var_7))));
comp += (-1.5960E-43f - (-1.7254E35f * -1.0943E35f + var_8));
}
if (comp <= (+1.4929E10f + var_9)) {
  float tmp_2 = +1.3666E-36f;
float tmp_3 = +1.7855E-11f;
comp += tmp_3 - tmp_2 * var_10 / floorf((var_11 / sqrtf(var_12 * +1.2344E34f / var_13 - var_14)));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15);
  cudaDeviceSynchronize();

  return 0;
}
