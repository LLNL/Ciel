SHELL=/bin/sh
BENCHMARK=cg
BENCHMARKU=CG

#---------------------------------------------------------------------------
#
#                SITE- AND/OR PLATFORM-SPECIFIC DEFINITIONS. 
#
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
# Items in this file will need to be changed for each platform.
# (Note these definitions are inconsistent with NPB2.1.)
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
# This is the C compiler used for OpenMP programs
#---------------------------------------------------------------------------
ifndef $(CC)
CC = g++-5
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
OTHER_FLAGS = -ffast-math
endif


# This links C programs; usually the same as ${CC}
CLINK	= $(CC)


#---------------------------------------------------------------------------
# These macros are passed to the linker 
#---------------------------------------------------------------------------
C_LIB  = -lm 


#---------------------------------------------------------------------------
# These macros are passed to the compiler 
#---------------------------------------------------------------------------
C_INC = -I../common 


#---------------------------------------------------------------------------
# Global *compile time* flags for C programs
#---------------------------------------------------------------------------
CFLAGS	= $(OPT) $(OTHER_FLAGS) -mcmodel=medium


#---------------------------------------------------------------------------
# Global *link time* flags. Flags for increasing maximum executable 
# size usually go here. 
#---------------------------------------------------------------------------
CLINKFLAGS = $(OPT) $(OTHER_FLAGS) -mcmodel=medium


#---------------------------------------------------------------------------
# Utilities C:
#
# This is the C compiler used to compile C utilities.  Flags required by 
# this compiler go here also; typically there are few flags required; hence 
# there are no separate macros provided for such flags.
#---------------------------------------------------------------------------
UCC	= g++


#---------------------------------------------------------------------------
# Destination of executables, relative to subdirs of the main directory. . 
#---------------------------------------------------------------------------
BINDIR	= .


#---------------------------------------------------------------------------
# The variable RAND controls which random number generator 
# is used. It is described in detail in Doc/README.install. 
# Use "randi8" unless there is a reason to use another one. 
# Other allowed values are "randi8_safe", "randdp" and "randdpvec"
#---------------------------------------------------------------------------
# RAND   = randi8
# The following is highly reliable but may be slow:
RAND   = randdp


#---------------------------------------------------------------------------
# The variable WTIME is the name of the wtime source code module in the
# NPB2.x/common directory.  
# For most machines,       use wtime.c
# For SGI power challenge: use wtime_sgi64.c
#---------------------------------------------------------------------------
WTIME  = wtime.cpp


#---------------------------------------------------------------------------
# Enable if either Cray or IBM: 
# (no such flag for most machines: see common/wtime.h)
# This is used by the C compiler to pass the machine name to common/wtime.h,
# where the C/Fortran binding interface format is determined
#---------------------------------------------------------------------------
# MACHINE	=	-DCRAY
# MACHINE	=	-DIBM




OBJS = cg.o ${COMMON}/c_print_results.o  \
       ${COMMON}/c_${RAND}.o ${COMMON}/c_timers.o ${COMMON}/c_wtime.o

PROGRAM  = $(BINDIR)/$(BENCHMARK).$(CLASS)
FCOMPILE = $(F77) -c $(F_INC) $(FFLAGS)
CCOMPILE = $(CC)  -c $(C_INC) $(CFLAGS)

CLASS=B

default:: ${PROGRAM}

COMMON=.
${COMMON}/${RAND}.o: ${COMMON}/${RAND}.f
	cd ${COMMON}; ${FCOMPILE} ${RAND}.f

${COMMON}/c_${RAND}.o: ${COMMON}/c_${RAND}.cpp
	cd ${COMMON}; ${CCOMPILE} c_${RAND}.cpp

${COMMON}/print_results.o: ${COMMON}/print_results.f
	cd ${COMMON}; ${FCOMPILE} print_results.f

${COMMON}/c_print_results.o: ${COMMON}/c_print_results.cpp
	cd ${COMMON}; ${CCOMPILE} c_print_results.cpp

${COMMON}/timers.o: ${COMMON}/timers.f
	cd ${COMMON}; ${FCOMPILE} timers.f

${COMMON}/c_timers.o: ${COMMON}/c_timers.cpp
	cd ${COMMON}; ${CCOMPILE} c_timers.cpp

${COMMON}/wtime.o: ${COMMON}/${WTIME}
	cd ${COMMON}; ${CCOMPILE} ${MACHINE} ${COMMON}/${WTIME}
# For most machines or CRAY or IBM
#	cd ${COMMON}; ${CCOMPILE} ${MACHINE} ${COMMON}/wtime.c
# For a precise timer on an SGI Power Challenge, try:
#	cd ${COMMON}; ${CCOMPILE} -o wtime.o ${COMMON}/wtime_sgi64.c

${COMMON}/c_wtime.o: ${COMMON}/${WTIME}
	cd ${COMMON}; ${CCOMPILE} -o c_wtime.o ${COMMON}/${WTIME}

# So that "make benchmark-name" works
${BENCHMARK}:  default
${BENCHMARKU}: default




${PROGRAM}: ${OBJS}
	${CLINK} ${CLINKFLAGS} -o ${PROGRAM} ${OBJS} ${C_LIB}

cg.o:             cg.cpp
	${CCOMPILE} cg.cpp

run:
	./cg.B

clean:
	- rm -f *.o *~ 
	- rm -f core
	- rm -rf workspace
	- rm -f ./cg.B *.out

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./cg.cpp -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./cg.cpp -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./cg.cpp -emit-llvm