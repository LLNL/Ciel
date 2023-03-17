#!/bin/bash
##===-------------------------------------------------------------------------------*- bash -*-===##
##
##                                   S E R I A L B O X
##
## This file is distributed under terms of BSD license. 
## See LICENSE.txt for more information.
##
##===------------------------------------------------------------------------------------------===##

ret=0

echo ''
echo 'Produce serialized data'
echo ''
./fortran_producer
ret=$((ret || $? ))

echo ''
echo 'Consume serialized data without pertubation'
echo ''
./fortran_consumer
ret=$((ret || $? ))

echo ''
echo 'Consume serialized data WITH pertubation'
echo ''
./fortran_consumer_perturb
ret=$((ret || $? ))

exit $ret
