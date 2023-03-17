
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10) {
float tmp_1 = +1.3526E-43f;
comp = tmp_1 - (-1.6277E-35f * +0.0f / var_1);
if (comp >= -1.4369E-43f / var_2 * +0.0f - -1.1795E-27f - (var_3 + var_4)) {
  comp += (-1.3787E7f + var_5);
}
if (comp > (+1.7559E3f / var_6 * var_7)) {
  comp += sinhf((var_8 + -0.0f * -1.1070E-30f * var_9 * var_10));
comp = (+1.8618E34f / (+0.0f - -1.1786E-37f + +1.3612E35f * +1.0141E35f + -1.5017E19f));
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11);
  cudaDeviceSynchronize();

  return 0;
}
