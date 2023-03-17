
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float* var_21,float var_22,float var_23,float var_24) {
comp += (-1.8025E35f + (var_3 + -1.3294E36f * (var_4 - var_5)));
float tmp_1 = -1.7807E-43f;
comp += tmp_1 / cosf(-1.5429E-21f);
comp += (var_6 * (var_7 * -1.3947E-36f - -1.9180E-8f + asinf((+1.4801E-41f - logf((+1.3532E7f / var_8 * -1.1467E35f))))));
if (comp > +1.5884E-44f * cosf(var_9 - sinhf((var_10 * floorf(+1.9366E-41f))))) {
  comp = var_11 + var_12 + var_13;
comp += var_14 / -1.9598E24f;
}
for (int i=0; i < var_1; ++i) {
  float tmp_2 = (var_15 * (-0.0f + (var_16 / (var_17 - -1.1200E34f + var_18))));
float tmp_3 = +1.2603E35f;
comp = tmp_3 - tmp_2 - (var_19 * (-1.2492E-42f * +1.9760E35f * -1.0139E34f * (+0.0f / var_20)));
}
for (int i=0; i < var_2; ++i) {
  var_21[i] = +1.9935E-37f + +1.7535E-37f + var_22 / +1.9573E-41f;
comp = var_21[i] + (var_23 / sinhf((-1.7727E-7f / (var_24 - (+1.5863E-41f * -1.7726E-36f)))));
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
  float* tmp_22 = initPointer( atof(argv[22]) );
  float tmp_23 = atof(argv[23]);
  float tmp_24 = atof(argv[24]);
  float tmp_25 = atof(argv[25]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25);
  cudaDeviceSynchronize();

  return 0;
}
