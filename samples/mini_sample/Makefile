ifndef $(CC)
CC = gcc
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
OPT += -ffast-math
endif

CFLAGS = 
LDFLAGS = $(LIBS) -lm

default: main

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

run:
	cat input.txt | ./test `xargs`

main: mk_workspace
	$(CC) test.cpp -o test $(CUDAFLAGS) $(OPT) $(LDFLAGS) 

clean:
	rm -rf *.o test *.out
	rm -rf workspace

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./test.cpp --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./test.cpp --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./test.cpp --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm