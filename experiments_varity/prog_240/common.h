__host__ __device__ void dump(const void *data, size_t len) {
    const unsigned char *x = (const unsigned char *)data;
    printf("%02x", x[0]);
    for (size_t k = 1; k < len; k++) 
      printf(" %02x", x[k]);
    printf("\n");
}