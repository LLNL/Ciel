ifndef $(CC)
CC = gcc
endif

ifeq ($(CC), gcc)
ARCH = gcc-9
CC = gcc-9
CXX = g++-9
FC = gfortran-9
LD = ld
endif

ifeq ($(CC), icc)
ARCH = icc
CC = icc
CXX = icpc
FC = ifort
LD = xild
endif

ifeq ($(CC), clang++)
ARCH = clang
CC = clang
CXX = clang++
FC = gfortran-9 # placeholder
LD = lld
endif

ifndef $(FASTMATH)
FASTMATH = 0
endif

default: main

main:
	touch arch/$(ARCH)/toolchain.cmake
	CC=$(CC) CXX=$(CXX) FC=$(FC) LD=$(LD) CMAKE_LINKER=$(LD) ./cloudsc-bundle build --clean --target=dwarf-cloudsc-c --arch=arch/$(ARCH)

run:
	build/bin/dwarf-cloudsc-c

clean:
	rm -rf build/
	rm -rf workspace *.out error.txt

mk_workspace:
	mkdir -p workspace
	mkdir -p workspace/extract_hierarchy
	mkdir -p workspace/original_files

extract_hierarchy: mk_workspace
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-function-analysis -c ./src/cloudsc_c/cloudsc/cloudsc_c.cpp -emit-llvm

enhance_precision: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-expand-precision -c ./src/cloudsc_c/cloudsc/cloudsc_c.cpp -emit-llvm

print_results: 
	clang -Xclang -load -Xclang Ciel-plugin.so -Xclang -plugin -Xclang -pliner-gpu-print-results -c ./src/cloudsc_c/cloudsc/cloudsc_c.cpp -emit-llvm