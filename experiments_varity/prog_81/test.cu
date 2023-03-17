
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float* var_3,float* var_4,float var_5,float var_6) {
if (comp == (-1.2118E35f * var_2)) {
  for (int i=0; i < var_1; ++i) {
    var_3[i] = +1.1286E-42f;
var_4[i] = +1.9543E-35f;
comp += var_4[i] / var_3[i] + (var_5 * var_6);
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
  float* tmp_4 = initPointer( atof(argv[4]) );
  float* tmp_5 = initPointer( atof(argv[5]) );
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7);
  cudaDeviceSynchronize();

  return 0;
}
