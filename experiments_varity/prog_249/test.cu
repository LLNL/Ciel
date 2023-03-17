
/* This is a automatically generated test. Do not modify */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "common.h"

__global__
void compute(float comp, int var_1,float var_2,float var_3,float var_4,float var_5,float var_6,float var_7,float var_8,float var_9,float var_10,float var_11,float var_12) {
for (int i=0; i < var_1; ++i) {
  comp = (var_2 + var_3 * (-1.2786E35f * (var_4 + -1.1209E34f - +1.7785E-36f)));
comp = (var_5 / +1.1265E35f / var_6 * var_7 - +1.9900E-25f - -1.7878E-29f);
comp += cosf((var_8 * -1.3333E36f / (-1.3913E-42f * -1.5517E-15f + var_9)));
if (comp > logf(+1.1179E-43f * (-1.1860E-41f / var_10 - cosf(tanhf((-1.4085E-42f + +1.4000E-44f)))))) {
  comp += +1.0035E0f / (var_11 + (-1.9734E35f + var_12));
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
  float tmp_9 = atof(argv[9]);
  float tmp_10 = atof(argv[10]);
  float tmp_11 = atof(argv[11]);
  float tmp_12 = atof(argv[12]);
  float tmp_13 = atof(argv[13]);

  compute<<<1,1>>>(tmp_1,tmp_2,tmp_3,tmp_4,tmp_5,tmp_6,tmp_7,tmp_8,tmp_9,tmp_10,tmp_11,tmp_12,tmp_13);
  cudaDeviceSynchronize();

  return 0;
}
