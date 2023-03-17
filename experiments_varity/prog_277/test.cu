
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,int var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
for (int i=0; i < var_1; ++i) {
  if (comp > (var_2 * (var_3 - (+1.8532E-43f / +1.9626E14f * (+1.7886E-37f * var_4))))) {
    if (comp >= (var_5 * (var_6 - var_7))) {
      comp += (-0.0f - sinhf((-0.0f / var_9 + floorf(+1.5832E-42f))));
float tmp_1 = -1.1252E-15f;
float tmp_2 = -1.3006E-24f;
comp += tmp_2 - tmp_1 - sinhf((-0.0f - (var_10 / var_11 + (var_12 / +1.1462E34f + var_13))));
if (comp >= atanf(+1.0472E-42f)) {
  float tmp_3 = -1.4667E36f;
comp += tmp_3 + (var_14 + (var_15 * var_16 * var_17));
}
for (int i=0; i < var_8; ++i) {
  comp = log10f(+1.2622E-35f);
}
if (comp == atan2f(floorf(+1.8171E-8f), (-1.3632E-43f / var_18 - (+0.0f - +1.9495E-41f)))) {
  comp = (-1.3993E25f / (+1.0080E-42f * var_19 + var_20));
}
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
  float tmp_4 = atof(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  int tmp_9 = atoi(argv[9]);
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

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21);
  cudaDeviceSynchronize();

  return 0;
}
