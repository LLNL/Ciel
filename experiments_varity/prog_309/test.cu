
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,float var_2,int var_3,int var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float* var_14,float var_15,float var_16,float var_17) {
if (comp >= (-0.0f - expf(-1.7786E19f + (-1.6951E21f + var_1 + (-1.5015E24f - var_2))))) {
  comp = (-1.4463E-24f + ceilf(var_5 + (var_6 / -1.3738E-44f - +1.8329E-6f - (-0.0f + var_7))));
if (comp < (var_8 - var_9)) {
  float tmp_1 = -1.0008E35f;
float tmp_2 = -1.9518E-36f;
float tmp_3 = -1.6526E36f;
comp = tmp_3 / tmp_2 + tmp_1 + sinhf((var_10 / (var_11 - -0.0f)));
}
for (int i=0; i < var_3; ++i) {
  comp += (var_12 + (var_13 - -1.0199E-36f));
}
for (int i=0; i < var_4; ++i) {
  comp += var_15 / +1.3643E-35f;
var_14[i] = -1.7821E-35f;
comp += var_14[i] * var_16 / var_17;
comp = cosf(-1.4415E27f);
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
  int tmp_5 = atoi(argv[5]);
  float tmp_6 = atof(argv[6]);
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float* tmp_15 = initPointer( atof(argv[15]) );
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);
  float tmp_18 = atof(argv[18]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18);
  cudaDeviceSynchronize();

  return 0;
}
