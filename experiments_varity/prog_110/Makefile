ifndef $(CC)
CC = clang++
endif

OPT = -O0

ifeq ($(OPT_LEVEL), 0)
OPT = -O0
endif

ifeq ($(OPT_LEVEL), 1)
OPT = -O1
endif

ifeq ($(OPT_LEVEL), 2)
OPT = -O2
endif

ifeq ($(OPT_LEVEL), 3)
OPT = -O3
endif

ifeq ($(FASTMATH), 1)
ifeq ($(CC), clang++)
OPT += -ffast-math
else ifeq ($(CC), nvcc)
OPT += -use_fast_math
endif
endif

ifndef $(LIBS)
LIBS = -lcudart_static -ldl -lrt -lpthread
endif

ifeq ($(CC), clang++)
CUDAFLAGS = --cuda-gpu-arch=$(CUDA_CC_VERSION) -L/usr/local/cuda/lib64
else
CUDAFLAGS = -arch=$(CUDA_CC_VERSION) --expt-relaxed-constexpr
endif

CFLAGS = 
LDFLAGS = $(LIBS)

default: main

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

run:
	cat input.txt | ./test `xargs`

main: mk_workspace
	$(CC) test.cu -o test $(CUDAFLAGS) $(OPT) $(LDFLAGS) 

clean:
	rm -rf *.o test *.out
	rm -rf workspace

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./test.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./test.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./test.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm