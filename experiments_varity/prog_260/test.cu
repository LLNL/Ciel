
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20) {
comp += sinf((var_3 + var_4 * sinhf(-1.3639E-28f + +1.4757E-25f)));
comp = +1.3487E-44f / +1.0463E35f - (var_5 / var_6 * +0.0f);
comp += (var_7 - var_8);
if (comp < (-1.0324E2f / -1.8803E36f * var_9 + var_10)) {
  comp = +1.4447E-21f * (+1.5484E-20f - sqrtf(-1.6733E-41f));
}
for (int i=0; i < var_1; ++i) {
  comp += var_11 - (var_12 * var_13);
float tmp_1 = -1.1326E11f;
comp = tmp_1 + (-1.1925E-43f - (-1.9516E-37f * ldexpf(-1.5474E27f + (+1.2125E36f - acosf(ceilf((+1.9126E-35f - +0.0f)))), 2)));
comp = +1.1504E-35f * (+1.1777E36f - +1.1876E34f + (+1.6106E34f - +1.7015E-35f));
}
for (int i=0; i < var_2; ++i) {
  comp = (var_14 - tanhf(var_15 * sinhf(var_16 + (var_17 - acosf(-0.0f / var_18 + var_19 * sinf((var_20 / -1.8291E-36f * -0.0f * (+1.4862E-37f / -1.4657E34f))))))));
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
