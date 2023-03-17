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

fileList = glob.glob(configDirBase + "/run_*.out")

prevSuccess = False
firstFile = True
for file in fileList:
    with open(file, "r") as f:
        if "successful" in f.read():
            success = True
        else:
            success = False

        if firstFile:
            firstFile = False
        else:
            if prevSuccess != success:
                exit(-1)
            
        prevSuccess = success
            
exit(0)