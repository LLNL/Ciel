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

all: euler3d euler3d_double

euler3d: euler3d.cu
	$(CC) $(KERNEL_DIM) $(CUDA_FLAG) euler3d.cu -o euler3d -lcudart_static -ldl -lrt -lpthread

euler3d_double: euler3d_double.cu
	$(CC) $(CUDA_FLAG) euler3d_double.cu -o euler3d_double -lcudart_static -ldl -lrt -lpthread

clean:
	rm -f euler3d euler3d_double pre_euler3d pre_euler3d_double *.linkinfo *.txt
	rm -rf workspace *.out

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

run:
	./euler3d fvcorr.domn.193K

run_ex:
	./euler3d_double fvcorr.domn.193K

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./euler3d.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./euler3d.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./euler3d.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm