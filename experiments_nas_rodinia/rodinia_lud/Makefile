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

ifeq ($(CC), clang++)
CUDA_FLAG = $(OPT) --cuda-gpu-arch=$(CUDA_CC_VERSION) -L/usr/local/cuda/lib64
else ifeq ($(CC), nvcc)
CUDA_FLAG = $(OPT) -Xptxas -v --gpu-architecture=compute_53 --gpu-code=compute_53
endif

default: lud

common.o: common.c
	$(CC) -c common.c $(CUDA_FLAG)

lud_base.o: lud_base.c
	$(CC) -c lud_base.c $(CUDA_FLAG)

lud_kernel.o: lud_kernel.cu
	$(CC) -c lud_kernel.cu $(CUDA_FLAG)

lud: common.o lud_base.o lud_kernel.o lud.cu
	$(CC) $^ -o $@ $(CUDA_FLAG) -lcudart_static -ldl -lrt -lpthread

clean: $(SRC)
	rm -f lud *.o
	rm -rf workspace *.out

.PHONY: run

run:
	./lud -s 256 -v

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./lud_kernel.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./lud_kernel.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./lud_kernel.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm
