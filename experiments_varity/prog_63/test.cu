
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float* var_4,float* var_5,float var_6,float var_7,float var_8) {
float tmp_1 = atanf(powf(+1.0120E-30f, -1.5396E-42f));
comp += tmp_1 / (var_2 / sinf((-1.2369E-41f - (+1.8445E35f - +1.8803E-36f / (+1.6660E-35f + (+0.0f * -1.6431E-41f))))));
if (comp >= (+1.0360E24f * var_3)) {
  comp += (-1.4489E-35f - +1.6863E-44f);
}
for (int i=0; i < var_1; ++i) {
  var_4[i] = (var_6 - var_7);
var_5[i] = -1.5390E36f;
comp = var_5[i] / var_4[i] / (var_8 - -1.6236E35f * +1.1913E-4f + -0.0f);
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
  float* tmp_5 = initPointer( atof(argv[5]) );
  float* tmp_6 = initPointer( atof(argv[6]) );
  float tmp_7 = atof(argv[7]);
  float tmp_8 = atof(argv[8]);
  float tmp_9 = atof(argv[9]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9);
  cudaDeviceSynchronize();

  return 0;
}
