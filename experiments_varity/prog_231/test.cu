
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,int var_3,float var_4,float var_5,float var_6,float var_7) {
if (comp > cosf(+0.0f / (-1.2242E34f * (-1.0814E-37f * sqrtf(+1.0582E-36f + (+1.5143E35f / (var_1 + var_2))))))) {
  float tmp_1 = +1.7283E-37f;
comp += tmp_1 / var_4 + (-1.4541E36f - var_5);
for (int i=0; i < var_3; ++i) {
  float tmp_2 = +1.2085E-35f;
float tmp_3 = -1.5980E36f;
comp += tmp_3 * tmp_2 + (+0.0f / var_6 / (-1.2555E-43f - (+1.7779E35f * (var_7 * -1.7309E-35f))));
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
  float tmp_3 = atof(argv[3]);
  int tmp_4 = atoi(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8);
  cudaDeviceSynchronize();

  return 0;
}
