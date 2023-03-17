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
print(fileList)
for fileName in fileList:
    with open(fileName, "r") as f:
        lines = f.readlines()
        for line in lines:
            if "failed" in line.strip().lower():
                exit(-1)

exit(0)