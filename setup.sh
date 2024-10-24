# fetch third-party libraries

# 1. fetch json.hpp 3.10.4
cd clang-examples/Ciel-plugin
if ! test -f json.hpp; then
    wget https://raw.githubusercontent.com/nlohmann/json/v3.10.4/single_include/nlohmann/json.hpp
fi
cd ../../

# 2. fetch gpuprec, apply patch
if ! test -d thirdparty/gpuprec; then
    git clone https://github.com/lumianph/gpuprec thirdparty/gpuprec
    cd thirdparty/gpuprec
    git checkout 452baddaf631f8810d7a70e452f0adfefed43fdd
    git apply ../../gpuprec_patch.txt
    cd ../../
fi

# 3. install Intel oneAPI because it is not strictly required and too large
# cd /tmp
# wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
# apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
# rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
# 
# echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
# apt update -y
# apt install intel-basekit=2022.3.0-8767 intel-hpckit=2022.3.0-8751 -y

# 4. install gcc 5.5 on Ubuntu 20.04

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/gcc-5-base_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/i/isl-0.18/libisl15_0.18-4_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/cpp-5_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/libasan2_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/libmpx0_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/libgcc-5-dev_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/gcc-5_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/libstdc++-5-dev_5.5.0-12ubuntu1_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-5/g++-5_5.5.0-12ubuntu1_amd64.deb

apt install ./g++-5_5.5.0-12ubuntu1_amd64.deb ./gcc-5_5.5.0-12ubuntu1_amd64.deb ./gcc-5-base_5.5.0-12ubuntu1_amd64.deb ./cpp-5_5.5.0-12ubuntu1_amd64.deb ./libisl15_0.18-4_amd64.deb ./libgcc-5-dev_5.5.0-12ubuntu1_amd64.deb ./libasan2_5.5.0-12ubuntu1_amd64.deb ./libmpx0_5.5.0-12ubuntu1_amd64.deb ./libstdc++-5-dev_5.5.0-12ubuntu1_amd64.deb -y
rm *.deb
