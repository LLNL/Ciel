
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float* var_11,float var_12,float var_13,float var_14,float var_15,float var_16) {
comp = +1.3931E-37f * +1.9547E-1f * (+1.0944E14f - logf(+1.8493E36f));
comp = (var_2 - -1.3692E7f + (var_3 - -1.9508E35f + -1.6681E36f / var_4));
float tmp_1 = (var_5 / +1.9037E34f);
comp = tmp_1 * -1.4246E-18f * var_6 - fabsf(-1.5294E-42f / (var_7 * (var_8 * (var_9 + +1.0429E24f - var_10))));
for (int i=0; i < var_1; ++i) {
  var_11[i] = tanhf(var_12 - +1.0808E36f * var_13 - -0.0f - var_14);
float tmp_2 = sinhf(var_15 - -1.0151E-35f);
comp = tmp_2 + var_11[i] * var_16 - (-0.0f / -1.3075E-44f);
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
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float* tmp_12 = initPointer( atof(argv[12]) );
  float tmp_13 = atof(argv[13]);
  float tmp_14 = atof(argv[14]);
  float tmp_15 = atof(argv[15]);
  float tmp_16 = atof(argv[16]);
  float tmp_17 = atof(argv[17]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17);
  cudaDeviceSynchronize();

  return 0;
}
