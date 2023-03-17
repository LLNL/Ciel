
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float* var_3,float* var_4,float var_5,float var_6,float var_7,float var_8) {
for (int i=0; i < var_1; ++i) {
  for (int i=0; i < var_2; ++i) {
    comp += (+1.2580E-8f + -0.0f - -1.2954E34f - +1.2309E-37f + (+0.0f - -1.8435E14f));
var_3[i] = sinhf((-1.8802E-43f + var_5 / (+1.7557E-42f / +1.5754E-36f)));
var_4[i] = -1.3126E-41f;
comp = var_4[i] + var_3[i] * var_6 + +1.6813E34f / floorf((var_7 + (-1.2129E-41f / var_8)));
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
  float* tmp_4 = initPointer( atof(argv[4]) );
  float* tmp_5 = initPointer( atof(argv[5]) );
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9);
  cudaDeviceSynchronize();

  return 0;
}
