
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float* var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12) {
comp += var_4 * +1.3940E-43f;
for (int i=0; i < var_1; ++i) {
  var_5[i] = (-0.0f + var_6);
comp += var_5[i] - var_7 / asinf(-1.7177E-35f + (+0.0f * +1.2918E-30f - -1.8518E-36f));
}
for (int i=0; i < var_2; ++i) {
  comp = -0.0f - coshf((var_8 / (var_9 / var_10 * -1.2304E34f)));
}
for (int i=0; i < var_3; ++i) {
  comp = ceilf(var_11 + +1.8874E-44f * var_12);
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
  int tmp_4 = atoi(argv[4]);
  float tmp_5 = atof(argv[5]);
  float* tmp_6 = initPointer( atof(argv[6]) );
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13);
  cudaDeviceSynchronize();

  return 0;
}
