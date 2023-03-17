#!/usr/bin/env python3
import os
import math
import re
import sys
import time

import json
import configparser
import subprocess

import glob

transformIndex = int(sys.argv[1])
dirPrefix = sys.argv[2]
configDirBase = "./workspace/" + dirPrefix + "{:03d}".format(transformIndex)

fileList = glob.glob(configDirBase + "/*/error.txt")

minList = []
maxList = []

firstFile = True
for fileName in fileList:
    with open(fileName, "r") as f:
        lines = f.readlines()
        index = 0
        for line in lines:
            offset = float(line.strip().split()[-1])
            if firstFile == True:
                minList.append(offset)
                maxList.append(offset)
            else:
                if minList[index] > offset:
                    minList[index] = offset
                if maxList[index] < offset:
                    maxList[index] = offset
            index += 1
    
    firstFile = False

diffList = []
index = 0
for item in minList:
    diffList.append(maxList[index]) # - minList[index])
    index += 1

maxDiff = 0.0

for diff in diffList:
    if diff > maxDiff:
        maxDiff = diff

print("max diff: " + str(maxDiff))

if maxDiff > 1e-11:
    exit(-1)
else:
    exit(0)