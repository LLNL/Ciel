//usr/bin/env nvcc --run "$0" ${1:+--run-args "${@:1}"} ; exit $?

// from https://stackoverflow.com/questions/40695455/what-utility-binary-can-i-call-to-determine-an-nvidia-gpus-compute-capability
#include <cstdio>
#include <cstdlib>
#include <cuda_runtime_api.h>

int main(int argc, char *argv[])
{
    cudaDeviceProp prop;
    cudaError_t status;
    int device_count;
    int device_index = 0;
    if (argc > 1) {
        device_index = atoi(argv[1]);
    }

    status = cudaGetDeviceCount(&device_count);
    if (status != cudaSuccess) {
        fprintf(stderr,"cudaGetDeviceCount() failed: %s\n", cudaGetErrorString(status));
        return -1;
    }
    if (device_index >= device_count) {
        fprintf(stderr, "Specified device index %d exceeds the maximum (the device count on this system is %d)\n", device_index, device_count);
        return -1;
    }
    status = cudaGetDeviceProperties(&prop, device_index);
    if (status != cudaSuccess) {
        fprintf(stderr,"cudaGetDeviceProperties() for device device_index failed: %s\n", cudaGetErrorString(status));
        return -1;
    }
    int v = prop.major * 10 + prop.minor;
    if (v > 86)
        v = 86;
    printf("sm_%d\n", v);
}