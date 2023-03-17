ifndef $(DEBUG)
DEBUG = 0
endif

# LLVM path: in the docker environment it is empty (root)
# export LLVM_PATH=/collab/usr/global/tools/fpchecker/llvm-12.0.0-install

# C++ compiler
CXX		= $(LLVM_PATH)/bin/clang++

# llvm-config location
LLVM_CONFIG     = $(LLVM_PATH)/bin/llvm-config

APPLE_LDFLAGS =-Wl,-flat_namespace -Wl,-undefined -Wl,suppress

# Passed to compiler
SRC_DIR		?= $(PWD)
ifeq ($(DEBUG), 1)
COMMON_FLAGS	= -Wall -O0 -g -std=c++11
else
COMMON_FLAGS	= -Wall -O3 -g -std=c++11
endif

LDFLAGS		+= $(shell $(LLVM_CONFIG) --ldflags) $(APPLE_LDFLAGS)
CXXFLAGS	+= $(COMMON_FLAGS) $(shell $(LLVM_CONFIG) --cxxflags) -fPIC -DFPC_DEBUG
CPPFLAGS	+= $(shell $(LLVM_CONFIG) --cppflags) -I$(SRC_DIR)

SHARED_LIB_OPT  = -shared

# Installation path
prefix		= /lib/

PROG		= Ciel-plugin.so

all: $(PROG)

source:
	$(CXX) $(CXXFLAGS) -o Ciel-plugin.o -c Ciel-plugin.cpp
	$(CXX) $(CXXFLAGS) -o ExpandPrecision.o -c ExpandPrecision.cpp
	$(CXX) $(CXXFLAGS) -o StmtRecursiveVisitor.o -c StmtRecursiveVisitor.cpp
	$(CXX) $(CXXFLAGS) -o FunctionAnalysis.o -c FunctionAnalysis.cpp
	$(CXX) $(CXXFLAGS) -o utils.o -c utils.cpp
	
	
$(PROG): source
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(SHARED_LIB_OPT) -o $(PROG) Ciel-plugin.o ExpandPrecision.o FunctionAnalysis.o utils.o StmtRecursiveVisitor.o

	@echo "Clang plugin build success."

install:
	cp $(PROG) $(prefix)
	@echo "Clang plugin installation success."

clean:
	$(RM) *.o $(PROG)
