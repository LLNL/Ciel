SHELL=/bin/sh
BENCHMARK=mg
BENCHMARKU=MG

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
OTHER_FLAGS = -ffast-math
else ifeq ($(CC), nvcc)
OTHER_FLAGS = -use_fast_math
endif
endif

#---------------------------------------------------------------------------
# Items in this file will need to be changed for each platform.
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
# Parallel C:
#
# CC         - C compiler 
# CFLAGS     - C compilation arguments
# C_INC      - any -I arguments required for compiling C 
# CLINK      - C linker
# CLINKFLAGS - C linker flags
# C_LIB      - any -L and -l arguments required for linking C 
#
# compilations are done with $(CC) $(C_INC) $(CFLAGS) or
#                            $(CC) $(CFLAGS)
# linking is done with       $(CLINK) $(C_LIB) $(CLINKFLAGS)
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
# This is the compiler used for CUDA programs
#---------------------------------------------------------------------------

ifeq ($(CC), nvcc)
COMPUTE_CAPABILITY = -arch=$(CUDA_CC_VERSION)

OPENMP = -Xcompiler -fopenmp -lgomp

REGISTERS = 

####-maxrregcount 50

# OPTIMIZATIONS = -use_fast_math -Xptxas --preserve-relocs -Xptxas -O3
OPTIMIZATIONS = -Xptxas --preserve-relocs -Xptxas $(OPT) $(OTHER_FLAGS)

CPP_14 = -std=c++14

NO_NPB_CPP_CONVENTIONS = -DDO_NOT_ALLOCATE_ARRAYS_WITH_DYNAMIC_MEMORY_AND_AS_SINGLE_DIMENSION

PROFILING = -DPROFILING

EXTRA_STUFF = ${COMPUTE_CAPABILITY} ${OPENMP} ${OPTIMIZATIONS} ${REGISTERS}

else ifeq ($(CC), clang++)

OPTIMIZATIONS = $(OPT) $(OTHER_FLAGS)

COMPUTE_CAPABILITY = --cuda-gpu-arch=$(CUDA_CC_VERSION)

EXTRA_STUFF = ${COMPUTE_CAPABILITY} ${OPTIMIZATIONS}

endif

COMPILER = ${CC} ${EXTRA_STUFF}

#---------------------------------------------------------------------------
# This links C programs; usually the same as ${CC}
#---------------------------------------------------------------------------
CLINK = $(COMPILER)

#---------------------------------------------------------------------------
# These macros are passed to the linker 
#---------------------------------------------------------------------------

ifeq ($(CC), nvcc)
C_LIB = -lm 
else ifeq ($(CC), clang++)
C_LIB = -lm -lcudart_static -ldl -lrt -lpthread -L/usr/local/cuda/lib64
endif

#---------------------------------------------------------------------------
# These macros are passed to the compiler 
#---------------------------------------------------------------------------
C_INC = 

#---------------------------------------------------------------------------
# Global *compile time* flags for C programs
#---------------------------------------------------------------------------
CFLAGS = $(OPT)

#---------------------------------------------------------------------------
# Global *link time* flags. Flags for increasing maximum executable 
# size usually go here. 
#---------------------------------------------------------------------------
CLINKFLAGS = $(OPT)

#---------------------------------------------------------------------------
# Utilities C:
#
# This is the C compiler used to compile C utilities. Flags required by 
# this compiler go here also; typically there are few flags required; hence 
# there are no separate macros provided for such flags.
#---------------------------------------------------------------------------
UCC	= cc

#---------------------------------------------------------------------------
# Destination of executables, relative to subdirs of the main directory. 
#---------------------------------------------------------------------------
BINDIR	= ./

#---------------------------------------------------------------------------
# The variable RAND controls which random number generator 
# is used. It is described in detail in Doc/README.install. 
# Use "randi8" unless there is a reason to use another one. 
# Other allowed values are "randi8_safe", "randdp" and "randdpvec"
#---------------------------------------------------------------------------
# RAND = randi8
# The following is highly reliable but may be slow:
RAND = randdp

#---------------------------------------------------------------------------
# The variable WTIME is the name of the wtime source code module in the
# NPB2.x/common directory.  
# For most machines,       use wtime.c
# For SGI power challenge: use wtime_sgi64.c
#---------------------------------------------------------------------------
WTIME = wtime.cpp

#---------------------------------------------------------------------------
# Enable if either Cray or IBM: 
# (no such flag for most machines: see common/wtime.h)
# This is used by the C compiler to pass the machine name to common/wtime.h,
# where the C/Fortran binding interface format is determined
#---------------------------------------------------------------------------
# MACHINE = -DCRAY
# MACHINE = -DIBM

OBJS = mg-no-cast.o c_print_results.o  \
       c_${RAND}.o c_timers.o c_wtime.o

include ./make.common

all: ${PROGRAM}

${PROGRAM}: mk_workspace ${OBJS}
	${CLINK} ${CLINKFLAGS} -o ${PROGRAM} ${OBJS} ${C_LIB}

mg-no-cast.o: mg-no-cast.cu npbparams.hpp
	${CCOMPILE} mg-no-cast.cu -o mg-no-cast.o

clean:
	- rm -f *.o *~ 
	- rm -rf workspace
	- rm -f core mg.S *.out

run:
	./mg.S

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./mg-no-cast.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./mg-no-cast.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./mg-no-cast.cu --cuda-gpu-arch=$(CUDA_CC_VERSION) -x cuda -emit-llvm