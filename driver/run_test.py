#!/usr/bin/env python3
import os
import math
import re
import sys
import time

import json
import configparser
import subprocess
from search import find_source_info, perform_func_search, perform_func_block_search, print_results, set_configs, perform_subexpression_search

MaxCCVersion = 7.5

# two ways to call the script: 
# - with no arguments: run the script in local directory
# - with single directory argument: run the script in the specified directory
DebugMode = False
UseExtendedPrecision = True
SearchInHeaders = False
SearchInHostFunctions = True
ParallelExecution = True
SubExpressionIsolation = True
CompilerList = ["nvcc"]
BlackList = []
WhiteList = []
SkipO0 = False

totalstart = time.time()

# read configs
if os.path.exists("./setup.ini"):
    config = configparser.ConfigParser()
    config.read("./setup.ini")
    if "basic" in config:
        if "UseExtendedPrecision" in config["basic"]:
            UseExtendedPrecision = config["basic"]["UseExtendedPrecision"].lower() == "yes"
        if "ParallelExecution" in config["basic"]:
            ParallelExecution = config["basic"]["ParallelExecution"].lower() == "yes"
        if "SearchInHeaders" in config["basic"]:
            SearchInHeaders = config["basic"]["SearchInHeaders"].lower() == "yes"
        if "DebugMode" in config["basic"]:
            DebugMode = config["basic"]["DebugMode"].lower() == "yes"
        if "SearchInHostFunctions" in config["basic"]:
            SearchInHostFunctions = config["basic"]["SearchInHostFunctions"].lower() == "yes"
        if "SubExpressionIsolation" in config["basic"]:
            SubExpressionIsolation = config["basic"]["SubExpressionIsolation"].lower() == "yes"
        if "BlackList" in config["basic"]:
            BlackList = config["basic"]["BlackList"].strip().split(":")
        if "WhiteList" in config["basic"]:
            WhiteList = config["basic"]["WhiteList"].strip().split(":")
        if "CompilerList" in config["basic"]:
            CompilerList = config["basic"]["CompilerList"].strip().split(":")
        if "SkipO0" in config["basic"]:
            SkipO0 = config["basic"]["SkipO0"].lower() == "yes"

set_configs(DebugMode, UseExtendedPrecision, SearchInHeaders, SearchInHostFunctions, ParallelExecution, CompilerList, SubExpressionIsolation, SkipO0)

# create temp files
os.system("make clean")
os.mkdir("./workspace")
os.mkdir("./workspace/original_files")
os.mkdir("./workspace/extract_hierarchy")

# build function analysis
with open("./extract_hierarchy.out", "w") as f:
    start = time.time()
    subprocess.run(["make", "extract_hierarchy"], stdout=f, stderr=subprocess.STDOUT)
    end = time.time()
    print("[timer] func analysis time: " + str(end - start))

funcs = find_source_info()

if WhiteList != []:
    newfuncs = {}
    for funcName in WhiteList:
        for fullName in funcs:
            if ("/" + funcName + ".json") in fullName:
                newfuncs[fullName] = funcs[fullName]
    funcs = newfuncs

for funcName in BlackList:
    for fullName in funcs:
        if ("/" + funcName + ".json") in fullName:
            funcs.pop(fullName)
            break

print("============= perform search =============")
# actual search goes here

HasSignatureChanged = 'signature' in sys.argv
print("has signature changed: " + str(HasSignatureChanged))
targetFuncs = perform_func_search(funcs, HasSignatureChanged)

if targetFuncs == None:
    # restart script
    os.execv(sys.executable, ['python3'] + sys.argv + ['signature'])

subFuncs = {}
for funcName in targetFuncs:
    subFuncs[funcName] = funcs[funcName]

perform_func_block_search(targetFuncs, subFuncs)

canPerformSubexpressionIsolation = print_results(subFuncs)

totalend = time.time()
print("[timer] total time: " + str(totalend - totalstart))

if SubExpressionIsolation == False:
    exit(0)

if canPerformSubexpressionIsolation:
    perform_subexpression_search()
else:
    exit(0)

totalend = time.time()
print("[timer] total time after subexpression isolation: " + str(totalend - totalstart))