docker container ls -a | grep 'ciel' &> /dev/null
if [ $? == 0 ]; then
    docker start ciel
    docker exec -it --user root ciel bash
else
    docker run --gpus all -it -v ~/trace_compare:/root/trace_compare --name ciel ucdavisplse/ciel:latest
fi