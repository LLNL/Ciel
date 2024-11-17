SHELL=/bin/sh
BENCHMARK=sp
BENCHMARKU=SP

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

include make.def

CLASS=A

include make.common

OBJS_CORE = sp.o initialize.o exact_solution.o exact_rhs.o \
       set_constants.o adi.o rhs.o      \
       x_solve.o ninvr.o y_solve.o pinvr.o    \
       z_solve.o tzetar.o add.o txinvr.o error.o

OBJS = sp.o initialize.o exact_solution.o exact_rhs.o \
       set_constants.o adi.o rhs.o      \
       x_solve.o ninvr.o y_solve.o pinvr.o    \
       z_solve.o tzetar.o add.o txinvr.o error.o verify.o  \
       ${COMMON}/print_results.o ${COMMON}/c_timers.o ${COMMON}/wtime.o

# npbparams.h is included by header.h
# The following rule should do the trick but many make programs (not gmake)
# will do the wrong thing and rebuild the world every time (because the
# mod time on header.h is not changed. One solution would be to 
# touch header.h but this might cause confusion if someone has
# accidentally deleted it. Instead, make the dependency on npbparams.h
# explicit in all the lines below (even though dependence is indirect). 

# header.h: npbparams.h

${PROGRAM}: ${OBJS}
	${CLINK} ${CLINKFLAGS} -o ${PROGRAM} ${OBJS} ${C_LIB}

.c.o:
	${CCOMPILE} $<

sp.o:             sp.c  header.h
initialize.o:     initialize.c  header.h
exact_solution.o: exact_solution.c  header.h
exact_rhs.o:      exact_rhs.c  header.h
set_constants.o:  set_constants.c  header.h
adi.o:            adi.c  header.h
rhs.o:            rhs.c  header.h
#lhsx.o:           lhsx.c  header.h
#lhsy.o:           lhsy.c  header.h
#lhsz.o:           lhsz.c  header.h
x_solve.o:        x_solve.c  header.h
ninvr.o:          ninvr.c  header.h
y_solve.o:        y_solve.c  header.h
pinvr.o:          pinvr.c  header.h
z_solve.o:        z_solve.c  header.h
tzetar.o:         tzetar.c  header.h
add.o:            add.c  header.h
txinvr.o:         txinvr.c  header.h
error.o:          error.c  header.h
verify.o:         verify.c  header.h

clean:
	- rm -f *.o *~ mputil* *.x
	- rm -f core
	- rm -rf workspace
	- rm -f ./sp.U.x *.out

run:
	./sp.U.x

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

clean_temp:
	rm -f workspace/*.c

extract_hierarchy: export CC = clang++
extract_hierarchy: export PLUGIN_FLAGS = -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -emit-llvm
extract_hierarchy: export CFLAGS =  

extract_hierarchy: mk_workspace ${OBJS_CORE}
	echo "function analysis done."

enhance_precision: export CC = clang++
enhance_precision: export PLUGIN_FLAGS = -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -emit-llvm
enhance_precision: export CFLAGS =  

enhance_precision: clean_temp ${OBJS_CORE}
	echo "raise precision done."

print_results: export CC = clang++
print_results: export PLUGIN_FLAGS = -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -emit-llvm
print_results: export CFLAGS =  

print_results: ${OBJS_CORE}
	echo "print results done."