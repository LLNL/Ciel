apt-get update -y
apt-get install -y apt-utils
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
apt-get upgrade -y
apt-get install -y python3=3.8.2-0ubuntu2 \
                    git=1:2.25.1-1ubuntu3.10 \
                    wget=1.20.3-1ubuntu2 \
                    build-essential=12.8ubuntu1.1 \
                    gcc=4:9.3.0-1ubuntu2 \
                    make=4.2.1-1.2 \
                    cmake=3.16.3-1ubuntu1.20.04.1 \
                    gfortran=4:9.3.0-1ubuntu2 \
                    libboost-all-dev=1.71.0.0ubuntu2 \
                    lsb-release=11.1.0ubuntu2 \
                    software-properties-common=0.99.9.11

git clone https://github.com/llvm/llvm-project/ /root/llvm-project
cd /root/llvm-project
git checkout tags/llvmorg-14.0.6

mkdir build
cd build
cmake -DLLVM_BUILD_EXAMPLES=1 -DCLANG_BUILD_EXAMPLES=1 -DLLVM_ENABLE_PROJECTS="clang;lld;lldb;openmp" -DCMAKE_INSTALL_PREFIX="" -DCMAKE_BUILD_TYPE="Release" -G "Unix Makefiles" ../llvm
make
make install