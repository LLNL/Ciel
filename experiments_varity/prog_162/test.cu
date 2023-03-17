
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8) {
if (comp >= sinf(ceilf(var_1 * ceilf(-1.3211E34f)))) {
  if (comp <= ldexpf(-1.1421E-41f - -1.8646E-36f, 2)) {
    float tmp_1 = -1.8883E-30f;
float tmp_2 = var_3 / +0.0f - (var_4 * -1.8210E4f);
comp = tmp_2 * tmp_1 - asinf(-1.2074E15f - var_5 - (var_6 * var_7));
for (int i=0; i < var_2; ++i) {
  comp += (-1.1728E-37f + +1.5173E-44f);
comp += (-1.1081E24f * -1.3726E-18f * var_8 - -1.2007E22f);
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
  float tmp_2 = atof(argv[2]);
  int tmp_3 = atoi(argv[3]);
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9);
  cudaDeviceSynchronize();

  return 0;
}
