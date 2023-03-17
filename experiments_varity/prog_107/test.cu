
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, float var_1,int var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12,float var_13,float var_14,float var_15,float var_16,float var_17,float var_18,float var_19,float var_20,float var_21,float var_22,float* var_23,float var_24,float var_25,float var_26,float var_27,float var_28) {
if (comp >= +1.8035E-44f * var_1 - ldexpf(sinhf(+1.7007E6f), 2)) {
  float tmp_1 = var_3 + -1.2161E24f;
comp = tmp_1 + var_4 / powf(coshf(sinhf(+1.0028E36f + (+1.4320E35f - var_5 / (var_6 + var_7)))), (-1.2913E35f / -1.0767E25f - sinf(var_8 + var_9)));
if (comp > (-1.9370E36f / coshf((var_10 + var_11)))) {
  comp = var_12 * logf(var_13 / (var_14 + var_15 / -1.0214E-44f));
comp += var_16 * (var_17 / (var_18 * log10f(-1.8316E36f + var_19 / (var_20 * (var_21 - var_22)))));
}
for (int i=0; i < var_2; ++i) {
  var_23[i] = (var_24 * fabsf(+1.6748E-43f));
comp += var_23[i] * log10f((+1.8275E-35f * +1.5333E34f));
}
if (comp == -1.2292E35f / (+1.4097E-14f * -1.3440E-43f / fabsf(var_25 - var_26 + +1.1116E-37f))) {
  comp = (var_27 - logf(+1.7451E8f));
comp += (+1.0251E-44f * var_28);
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
  float tmp_22 = atof(argv[22]);
  float tmp_23 = atof(argv[23]);
  float* tmp_24 = initPointer( atof(argv[24]) );
  float tmp_25 = atof(argv[25]);
  float tmp_26 = atof(argv[26]);
  float tmp_27 = atof(argv[27]);
  float tmp_28 = atof(argv[28]);
  float tmp_29 = atof(argv[29]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13,tmp_14,tmp_15,tmp_16,tmp_17,tmp_18,tmp_19,tmp_20,tmp_21,tmp_22,tmp_23,tmp_24,tmp_25,tmp_26,tmp_27,tmp_28,tmp_29);
  cudaDeviceSynchronize();

  return 0;
}
