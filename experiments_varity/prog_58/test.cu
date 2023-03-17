
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,int var_3,float var_4,float var_5,float* var_6,float* var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float* var_14,float var_15) {
if (comp > +1.5118E34f * ceilf((var_4 + var_5))) {
  for (int i=0; i < var_1; ++i) {
    float tmp_1 = -1.3065E-36f;
float tmp_2 = +1.2489E3f;
comp += tmp_2 - tmp_1 * -1.6165E-36f + -1.1804E-44f;
for (int i=0; i < var_2; ++i) {
  var_6[i] = (var_8 * (-0.0f - sinhf(cosf(-0.0f * (var_9 * var_10 * var_11)))));
var_7[i] = -1.4603E36f;
comp = var_7[i] / var_6[i] - (+1.8357E-37f + var_12 * var_13);
comp = -1.6243E25f - -1.1032E36f / +1.0991E10f;
}
for (int i=0; i < var_3; ++i) {
  var_14[i] = +1.7771E-12f;
comp = var_14[i] - sqrtf(+1.4712E35f / +1.3325E-41f + -1.2108E-37f / (var_15 - acosf(ldexpf(sinf(+1.8169E-43f), 2))));
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
  int tmp_3 = atoi(argv[3]);
  int tmp_4 = atoi(argv[4]);
  float tmp_5 = atof(argv[5]);
  float tmp_6 = atof(argv[6]);
  float* tmp_7 = initPointer( atof(argv[7]) );
  float* tmp_8 = initPointer( atof(argv[8]) );
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float* tmp_15 = initPointer( atof(argv[15]) );
  float tmp_16 = atof(argv[16]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16);
  cudaDeviceSynchronize();

  return 0;
}
