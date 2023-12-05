# Use a temporary Clang 16 container here, but this makes GCC 5.x not installable.

docker container ls -a | grep 'ciel' &> /dev/null
if [ $? == 0 ]; then
    docker start ciel
    docker exec -it --user root ciel bash
else
    docker run --gpus all -it -v ~/Ciel:/root/ciel --name ciel doloresmiao/gpu-testing:clang16-cuda12.0
fi