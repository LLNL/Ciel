# Instructions on Running this mini_sample

1. Pull and run the docker container

```
./run_docker.sh
```

2. Setup environments and Build the Clang plugins

```
cd /root/ciel
source setup.sh
source driver/setup_cc.sh
./build_single_plugin.sh
```

Plugin compilation is done correctly when you see `Clang plugin installation
success.` in the output.

3. Compile and run the program with different compiler command lines

```
make OPT_LEVEL=0 FASTMATH=0
make run # check results
make clean
make OPT_LEVEL=3 FASTMATH=1
make run # check results, there is expected to be an inconsistency
make clean
```

4. Run Ciel to isolate code that causes inconsistency

```
python3 ~/ciel/driver/run_test.py
```

Compare outputs with sample output `results.txt`.