#!/usr/bin/env python3
import os
from pickle import FALSE
import signal
import math
import subprocess
import filecmp
import time
from enum import Enum, IntEnum
from posixpath import split
import multiprocessing as mp
import re
import sys
import shutil
import json
import copy

# sync with utils.h BLOCK_TYPE_* macros
class BlockType(IntEnum):
    BASIC = 0          # basic
    LOOP = 1           # for, while, do while
    LOOP_COMPONENT = 2 # loop cond + body
    COND = 3           # switch case, if
    COND_COMPONENT = 4 # if/switch cond + body 
    FUNC = 5           # function body

class BlockStatus(IntEnum):
    DISABLED = 0
    PARTIAL_ENABLED = 1
    ENABLED = 2
    INDIVIDUAL_ENABLED = 3

class SubExType(IntEnum):
    OTHER = 0
    FUNC = 1
    VAR = 2
    CALLEXPR = 3
    OP = 4

class Compiler(Enum):
    NVCC = "nvcc"
    CLANG = "clang++"
    GCC = "gcc"
    GCC5 = "gcc-5"
    CLANGC = "clang"
    ICC = "icc"

class OptLevel(Enum):
    O0 = ["OPT_LEVEL=0", "FASTMATH=0"]
    O3_fastmath = ["OPT_LEVEL=3", "FASTMATH=1"]

transformIndex = 0
DebugMode = False
UseExtendedPrecision = True
SearchInHeaders = False
SearchInHostFunctions = True
ParallelExecution = True
SubExpressionIsolation = False
CompilerList = ["nvcc"]
SkipO0 = False

TotalTransformTime = 0.0
TotalCompileRunTime = 0.0

def set_configs(mode, extend_precision, search_headers, search_host_funcs, parallel_execution, compiler_list, sub_expression_isolation, skip_o0):
    global DebugMode
    global UseExtendedPrecision
    global SearchInHeaders
    global SearchInHostFunctions
    global ParallelExecution
    global SubExpressionIsolation
    global CompilerList
    global SkipO0
    DebugMode = mode
    UseExtendedPrecision = extend_precision
    SearchInHeaders = search_headers
    SearchInHostFunctions = search_host_funcs
    ParallelExecution = parallel_execution
    SubExpressionIsolation = sub_expression_isolation
    CompilerList = compiler_list
    SkipO0 = skip_o0

def find_source_info():
    funcs = {}

    # look for all source files
    for root, dirs, files in os.walk("./workspace/extract_hierarchy", topdown=False):
        for name in files:
            if name.endswith(".json"):
                fullName = os.path.join(root, name)
                with open(fullName, "r") as f:
                    funcStructure = json.load(f)
                    if funcStructure["fpcount"] > 0:
                        funcs[fullName] = funcStructure

    return funcs

def compile_and_run(cc, level, transformCounter, retValue, subexpression):
    global transformIndex
    retValue.value = 0
    # copy all files to destination
    if subexpression:
        dirPrefix = "config_sub_"
    else:
        dirPrefix = "config_"

    tempPath = "./workspace/" + dirPrefix + "{:03d}".format(transformIndex) + "/" + str(transformCounter) + "/"
    fullTempPath = os.path.abspath(tempPath)
    origPath = os.getcwd()
    if os.path.exists(tempPath):
        shutil.rmtree(tempPath)
    shutil.copytree(origPath, fullTempPath, ignore=shutil.ignore_patterns("workspace"), symlinks=True)
    os.chdir(tempPath)

    outFile = os.path.join(origPath, "build_" + cc.name + "_" + level.name + ".out")
    command = ["make", "CC=" + cc.value]
    command.extend(level.value)
    try:
        with open(outFile, "w") as f:
            subprocess.check_call(command, stdout=f, stderr=subprocess.STDOUT) # stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(str(e.output) + " : exiting")
        retValue.value = 1
        return

    # run and gather result. TODO: on multiple configs, simultaneously
    outFile = os.path.join(origPath, "run_" + cc.name + "_" + level.name + ".out")
    if os.path.exists(outFile):
        os.system("rm " + outFile)
    with open(outFile, "w") as f:
        subprocess.run(["make", "run"], stdout=f, cwd=fullTempPath, bufsize=1)
        sys.stdout.flush()

    os.chdir(origPath)  

def precision_enhance():
    outFile = "enhance_precision.out"
    if os.path.exists("./" + outFile):
        os.system("rm " + outFile)
    with open(outFile, "w") as f:
        try:
            subprocess.check_call(["make", "enhance_precision"], stdout=f, stderr=subprocess.STDOUT)
        except subprocess.CalledProcessError as e:
            print(str(e.output) + " : exiting")
            os.system("touch ./transform_error.out")
            exit()

def backup_source_files():
    # copy file to destination
    for root, dirs, filenames in os.walk("./workspace/original_files"):
        for fileName in filenames:
            transformedFilename = os.path.join("./workspace", fileName)
            # get first line of this file, which is the source file name
            with open(os.path.join("./workspace/original_files", fileName), "r", errors='ignore') as f:
                line = f.readline()
                originalFilename = line.strip().split(" ")[1]
                
                # copy transformed file to destination
                os.system("cp " + transformedFilename + " " + originalFilename)
        return

def restore_source_files():
    for root, dirs, filenames in os.walk("./workspace/original_files"):
        for fileName in filenames:
            backupFilename = os.path.join("./workspace/original_files", fileName)
            lines = []
            # get first line of this file, which is the source file name
            with open(backupFilename, "r", errors='ignore') as f:
                lines = f.readlines()
                originalFilename = lines[0].strip().split(" ")[1]

            lines = lines[1:]

            with open(originalFilename, "w") as f:
                f.writelines(lines)
        return

def transform_and_evaluate(doRestoreFiles, subexpression):
    global transformIndex
    global DebugMode
    global ParallelExecution
    global TotalTransformTime
    global TotalCompileRunTime
    global CompilerList
    global SkipO0
    # transform the program
    transformstart = time.time()
    precision_enhance()
    transformend = time.time()
    print("[timer] transform time for " + str(transformIndex) + ": " + str(transformend - transformstart))
    TotalTransformTime = TotalTransformTime + transformend - transformstart

    # debug convenience
    if DebugMode:
        input("step end.")

    backup_source_files()

    if subexpression:
        dirPrefix = "config_sub_"
    else:
        dirPrefix = "config_"

    configTempDir = "./workspace/" + dirPrefix + "{:03d}".format(transformIndex) + "/"
    os.makedirs(configTempDir, exist_ok=True)

    # compile and run, in parallel
    prevOutFile = ""
    hasSolvedDiscrepancy = True
    transformCounter = 0
    processList = []
    compilerunstart = time.time()
    hasError = False
    for cc in Compiler:
        if not cc.value in CompilerList:
            continue
        for level in OptLevel:
                if "O0" in level.name and SkipO0:
                    continue
                origPath = os.getcwd()
                retValue = mp.Value("i", 0, lock=True)
                if ParallelExecution == False:
                    compile_and_run(cc, level, transformCounter, retValue, subexpression)
                    if retValue.value != 0:
                        print("Exiting...")
                        hasError = True
                        break
                else:
                    process = mp.Process(target=compile_and_run, args=(cc, level, transformCounter, retValue, subexpression, ))
                    process.start()
                    processList.append((process, retValue))
                transformCounter = transformCounter + 1

    if ParallelExecution == True:
        for processItem in processList:
            process = processItem[0]
            retValue = processItem[1]
            process.join()
            if retValue.value != 0:
                print("Exiting...")
                hasError = True
                break

    compilerunend = time.time()
    print("[timer] compile run time for " + str(transformIndex) + ": " + str(compilerunend - compilerunstart))
    TotalCompileRunTime = TotalCompileRunTime + compilerunend - compilerunstart

    os.system("cp *.out " + configTempDir)

    if hasError == False:
        # compare output files with simple binary file comparisons.
        # if there is a comparison script, use it.
        if os.path.exists("./compare.py"):
            retcode = subprocess.call(["python3", "./compare.py", str(transformIndex), dirPrefix])
            hasSolvedDiscrepancy = (retcode == 0)
        else:
            for cc in Compiler:  
                if not cc.value in CompilerList:
                    continue      
                for level in OptLevel:
                    if "O0" in level.name and SkipO0:
                        continue
                    outFile = os.path.join(origPath, "run_" + cc.name + "_" + level.name + ".out")
                    if prevOutFile != "" and filecmp.cmp(prevOutFile, outFile, shallow=False) == False:
                    #with open(outFile, "r") as f:
                    #    text = f.read()
                    #    if not "FAILED" in text:
                        hasSolvedDiscrepancy = False
                    prevOutFile = outFile

    # restore file 
    if doRestoreFiles:
        restore_source_files()
    # for special cases where no files are restored, we should also make another copy
    else:
        for root, dirs, filenames in os.walk("./workspace/original_files"):
            for fileName in filenames:
                transformedFilename = os.path.join("./workspace", fileName)
                backupFilename = os.path.join("./workspace/original_files", fileName)
                lines = []
                # get first line of this file, which is the source file name
                with open(backupFilename, "r", errors='ignore') as f:
                    lines.append(f.readline())
                    originalFilename = lines[0].strip().split(" ")[1]

                # read transform file (only signature is changed), write it to original file/backup original file
                transformedLines = []
                with open(transformedFilename, "r", errors='ignore') as f:
                    transformedLines = f.readlines()

                lines = lines + transformedLines
                with open(originalFilename, "w") as f:
                    f.writelines(transformedLines)
                
                with open(backupFilename, "w") as f:
                    f.writelines(lines)
            break

    transformIndex = transformIndex + 1

    if hasError == True:
        os.system("touch ./compile_error.out")
        exit()

    os.system("touch " + os.path.join(configTempDir, "discrepancy_solved_" + str(hasSolvedDiscrepancy)))
    os.system("cp ./workspace/transform_list.txt " + configTempDir)

    # if discrepancy is solved with raising precision, then this subset of transforms contain the buggy code
    print("has enhancing precision resolve inconsistency: " + str(hasSolvedDiscrepancy))
    return hasSolvedDiscrepancy

def transform_function_list(funcActiveArray, funcList, funcDict, transformSignature):
    index = 0
    sublist = []
    for funcActive in funcActiveArray:
        if funcActive:
            sublist.append(funcList[index])
        index = index + 1

    if sublist:
        # output temporary file for transformation
        with open("./workspace/transform_list.txt", "w") as f:
            if transformSignature:
                f.write("signature\n")
            else:
                f.write("func\n")
            for func in sublist:
                filename = os.path.dirname(func).split("/")[-1]
                split_filename = filename.rsplit("_", 1)
                filename = ".".join(split_filename)
                f.write(filename + ":" + func + "\n")

    hasSolvedDiscrepancy = transform_and_evaluate(transformSignature == False, False)

    return hasSolvedDiscrepancy

def perform_func_search(funcDict, HasSignatureChanged):

    # do a binary search in functions, to find the offending function(s).
    funcList = []
    funcActiveArray = []
    for funcName in sorted(funcDict.keys()):
        filename = os.path.dirname(funcName).split("/")[-1]
        split_filename = filename.rsplit("_", 1)
        filename = ".".join(split_filename)
        funcList.append(funcName)
        funcActiveArray.append(True)

    tempArray = funcActiveArray.copy()
    for i in range(0, len(tempArray)):
        tempArray[i] = False
    result_none = transform_function_list(tempArray, funcList, funcDict, False)
    if result_none == True:
        print("there is no inconsistencies?")
        os.system("touch ./no_issue.out")
        exit()
    
    result_all = transform_function_list(funcActiveArray, funcList, funcDict, False)

    if result_all == False:
        print("strange, cannot resolve inconsistency even all functions are transformed")
        if HasSignatureChanged:
            print("enhancing precision cannot resolve this inconsistency.")
            os.system("touch ./cant_solve.out")
            exit(0)

        result_all = transform_function_list(funcActiveArray, funcList, funcDict, True)
        #result_all = True
        if result_all == True:
            print("but transforming function signature can solve inconsistency.")
            os.system("touch ./signature.out")
            exit()
        else:
            # restart script with the new source files
            os.system("touch ./signature_loc.res")
            return None

    startpos = 0
    endpos = len(funcDict)
    funcActiveArray = func_search_recurse(startpos, endpos, funcActiveArray, funcDict, funcList)

    retFuncList = []

    index = 0
    for funcActive in funcActiveArray:
        if funcActive:
            retFuncList.append(funcList[index])
        index = index + 1

    return retFuncList

def func_search_recurse(startpos, endpos, funcActiveArray, funcDict, funcList):
    while True:
        # if there is only one function, this is it!
        if startpos >= endpos - 1:
            return funcActiveArray
        midpos = math.floor((startpos + endpos) / 2)

        tempArray1 = funcActiveArray.copy()
        for idx in range(startpos, midpos):
            tempArray1[idx] = False
        result1 = transform_function_list(tempArray1, funcList, funcDict, False)

        if result1:
            funcActiveArray = tempArray1
            startpos = midpos
            continue

        tempArray2 = funcActiveArray.copy()
        for idx in range(midpos, endpos):
            tempArray2[idx] = False
        result2 = transform_function_list(tempArray2, funcList, funcDict, False)

        if result2:
            funcActiveArray = tempArray2
            endpos = midpos
        else:
            # worse case, we need to find amongst both half
            tempArray1 = func_search_recurse(startpos, midpos, funcActiveArray, funcDict, funcList)
            return func_search_recurse(midpos, endpos, tempArray1, funcDict, funcList)

def transform_sub_function_list(funcStructureDict):
    os.system("rm -rf ./workspace/transform_temp")

    with open("./workspace/transform_list.txt", "w") as f:
        f.write("block\n")
        for func in funcStructureDict.keys():
            funcStructure = funcStructureDict[func]
            tempJsonFile = func.replace("extract_hierarchy", "transform_temp")
            os.makedirs(os.path.dirname(tempJsonFile), exist_ok=True)
            with open(tempJsonFile, "w") as jsonFile:
                json.dump(funcStructure, jsonFile, indent=4)
            filename = os.path.dirname(func).split("/")[-1]
            split_filename = filename.rsplit("_", 1)
            filename = ".".join(split_filename)
            f.write(filename + ":" + tempJsonFile + "\n")

    hasSolvedDiscrepancy = transform_and_evaluate(True, False)

    return hasSolvedDiscrepancy

def perform_func_block_search(funcList, funcStructureDict):
    for func in funcList:
        funcStructure = funcStructureDict[func]
        perform_block_search(func, funcStructure, funcStructureDict)

def perform_block_search(func, funcStructure, funcStructureDict):
    startpos = 0
    listText = "stmts"
    if "blocks" in funcStructure:
        listText = "blocks"
    endpos = len(funcStructure[listText])

    # for loops and condition statements, do not split the condition part.
    print("====== begin " + listText + " search of " + func + " from " + str(startpos) + " to " + str(endpos) + " ======")    

    for idx in range(startpos, endpos):
        print("block " + str(idx) + " fpcount: " + str(funcStructure[listText][idx]["fpcount"]))

    if startpos < endpos - 1:
        if listText == "stmts":
            block_search_recurse(listText, startpos, endpos, func, funcStructure, funcStructureDict)
        else:
            loops = []
            for idx in range(startpos, endpos):
                if funcStructure[listText][idx]["type"] == BlockType.LOOP:
                    loops.append(idx)
            
            print("loops in this level: " + str(loops))
            if len(loops) > 0:
                for idx in range(startpos, endpos):
                    if not idx in loops:
                        funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED

                startlooppos = 0
                endlooppos = len(loops)

                # transform all loops
                result = transform_sub_function_list(funcStructureDict)

                if result:
                    loop_search_recurse(listText, loops, startlooppos, endlooppos, func, funcStructure, funcStructureDict)
                else:
                    for idx in range(startpos, endpos):
                        funcStructure[listText][idx]["enabled"] = BlockStatus.ENABLED
                    block_search_recurse(listText, startpos, endpos, func, funcStructure, funcStructureDict)
            else:
                block_search_recurse(listText, startpos, endpos, func, funcStructure, funcStructureDict)

    if listText == "blocks":
        index = 0
        for block in funcStructure[listText]:
            if index >= startpos and block["enabled"] != 0:
                print("====== enter block " + str(index) + " ======")    

                perform_block_search(func, block, funcStructureDict)
            index += 1

def loop_search_recurse(listText, loops, startlooppos, endlooppos, func, funcStructure, funcStructureDict):
   while True:
        if startlooppos >= endlooppos - 1:
            return
        
        midlooppos = math.floor((startlooppos + endlooppos) / 2)
        hasLeft = False
        hasRight = False

        for idx in range(startlooppos, midlooppos):
            if funcStructure[listText][loops[idx]]["fpcount"] > 0:
                hasLeft = True
        for idx in range(midlooppos, endlooppos):
            if funcStructure[listText][loops[idx]]["fpcount"] > 0:
                hasRight = True
        
        if hasLeft and hasRight:
            for idx in range(midlooppos, endlooppos):
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.DISABLED
            result1 = transform_sub_function_list(funcStructureDict)
            for idx in range(midlooppos, endlooppos):
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.ENABLED     

            if result1:
                for idx in range(midlooppos, endlooppos):
                    funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.DISABLED    
                endlooppos = midlooppos
                continue

            for idx in range(startlooppos, midlooppos):         
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.DISABLED
            result2 = transform_sub_function_list(funcStructureDict)  
            for idx in range(startlooppos, midlooppos):
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.ENABLED       
        else:
            result1 = hasLeft
            result2 = hasRight    

        #if result1 and result2:
        #    assert False, "both side can resolve discrepancy? I do not think this will happen"
        if result1:
            for idx in range(midlooppos, endlooppos):
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.DISABLED    
            endlooppos = midlooppos
        elif result2:
            for idx in range(startlooppos, midlooppos):
                funcStructure[listText][loops[idx]]["enabled"] = BlockStatus.DISABLED    
            startlooppos = midlooppos
        else:
            loop_search_recurse(listText, loops, startlooppos, midlooppos, func, funcStructure, funcStructureDict)
            loop_search_recurse(listText, loops, midlooppos, endlooppos, func, funcStructure, funcStructureDict)
            return

def block_search_recurse(listText, startpos, endpos, func, funcStructure, funcStructureDict):
    while True:
        if startpos >= endpos - 1:
            return
        midpos = math.floor((startpos + endpos) / 2)

        hasLeft = False
        hasRight = False

        for idx in range(startpos, midpos):
            if funcStructure[listText][idx]["fpcount"] > 0:
                hasLeft = True       
        for idx in range(midpos, endpos):
            if funcStructure[listText][idx]["fpcount"] > 0:
                hasRight = True

        if hasLeft and hasRight:
            # test left half only
            for idx in range(midpos, endpos):
                funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED
            result1 = transform_sub_function_list(funcStructureDict)
            for idx in range(midpos, endpos):
                funcStructure[listText][idx]["enabled"] = BlockStatus.ENABLED

            if result1:
                for idx in range(midpos, endpos):
                    funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED    
                endpos = midpos
                continue

            # test right half only
            for idx in range(startpos, midpos):         
                funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED
            result2 = transform_sub_function_list(funcStructureDict)  
            for idx in range(startpos, midpos):
                funcStructure[listText][idx]["enabled"] = BlockStatus.ENABLED
        else:
            result1 = hasLeft
            result2 = hasRight
            
        #if result1 and result2:
        #    assert False, "both side can resolve discrepancy? I do not think this will happen"
        if result1:
            for idx in range(midpos, endpos):
                funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED    
            endpos = midpos
        elif result2:
            for idx in range(startpos, midpos):
                funcStructure[listText][idx]["enabled"] = BlockStatus.DISABLED    
            startpos = midpos
        else:
            block_search_recurse(listText, startpos, midpos, func, funcStructure, funcStructureDict)
            block_search_recurse(listText, midpos, endpos, func, funcStructure, funcStructureDict)
            return

def read_isolation_results(subEx, deleteFile):
    canPerformSubexpressionIsolation = False
    with open("./results.out", "r") as f:
        lines = f.readlines()
        for line in lines:
            if "Has continuous statements:" in line:
                if "yes" in line.strip():
                    deleteFile = False
                else:
                    deleteFile = True
                    canPerformSubexpressionIsolation = True
            print(line.strip())
    if subEx == False and deleteFile:
        os.system("rm -f ./results.out")
    print("----- end of results -----")
    return canPerformSubexpressionIsolation

def print_results(funcStructureDict):
    global TotalCompileRunTime
    global TotalTransformTime
    os.system("rm -rf ./workspace/transform_temp")

    with open("./workspace/transform_list.txt", "w") as f:
        f.write("block\n")
        for func in funcStructureDict.keys():
            funcStructure = funcStructureDict[func]
            tempJsonFile = func.replace("extract_hierarchy", "transform_temp")
            os.makedirs(os.path.dirname(tempJsonFile), exist_ok=True)
            with open(tempJsonFile, "w") as jsonFile:
                json.dump(funcStructure, jsonFile, indent=4)
            filename = os.path.dirname(func).split("/")[-1]
            split_filename = filename.rsplit("_", 1)
            filename = ".".join(split_filename)
            f.write(filename + ":" + tempJsonFile + "\n")

    command = ["make", "print_results"]
    subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)

    ret = read_isolation_results(False, False)

    print("[timer] Total Transform Time: " + str(TotalTransformTime))
    print("[timer] Total Compile Run Time: " + str(TotalCompileRunTime))

    return ret

def transform_subexpression_list(stmtInfos):
    with open("./subex_isolation.out", "w") as f:
        for stmt in stmtInfos:
            f.write(stmt[0] + ";")
            f.write(",".join([str(x) for x in stmt[1]]) + ";")
            f.write(",".join([str(x) for x in stmt[2]]) + ";")
            f.write(",".join([str(x) for x in stmt[3]]) + ";")
            f.write(",".join([str(x) for x in stmt[4]]) + "\n")

    return transform_and_evaluate(True, True)

def isAncestor(j, k, arr):
    pos = k
    while True:
        pos = arr[pos]
        if j == pos:
            return True
        elif pos == -1:
            return False

def perform_subexpression_search():
    global TotalCompileRunTime
    global TotalTransformTime    
    stmtInfos = []
    with open("./subex_isolation.out", "r") as f:
        lines = f.readlines()
        # compute;0,0;0;-1,0,0,2,3,2,5,6,5,8,9,8,11
        for line in lines:
            stmt = line.split(";")
            stmt[1] = [int(x) for x in stmt[1].split(",")]
            stmt[2] = [int(stmt[2])]
            stmt[3] = [int(x) for x in stmt[3].split(",")]
            stmt[4] = [int(x) for x in stmt[4].split(",")]
            print(str(stmt[1]) + ":" + str(stmt[3]))
            stmtInfos.append(stmt)
    for stmt in stmtInfos:
        substmt = stmt[2]
        i = 0
        while i < len(stmt[2]):
            node = substmt[i]
            isLeaf = True
            eligibleSet = set()
            for j in range(len(stmt[3])):
                if node == stmt[3][j]:
                    substmt[i] = j
                    isLeaf = False
                    print("new config " + str(substmt))
                    resolved = transform_subexpression_list(stmtInfos)
                    if resolved:
                        eligibleSet.add(j)
                    substmt[i] = node
            print("eligible set num " + str(len(eligibleSet)))
            if isLeaf:
                i += 1
            elif len(eligibleSet) == 1:
                substmt.remove(node)
                for j in eligibleSet:
                    substmt.insert(i, j)
            elif len(eligibleSet) > 1:
                substmt.remove(node)
                goodCandidate = False
                firstItem = -1
                for j in eligibleSet:
                    if firstItem == -1:
                        firstItem = j
                    for k in range(len(stmt[3])):
                        if isAncestor(j, k, stmt[3]) and stmt[4][k] == 2:
                            goodCandidate = True
                            break
                    if goodCandidate:
                        substmt.insert(i, j)
                        break
                if not goodCandidate:
                    substmt.insert(i, firstItem)
            else:
                substmt.remove(node)
                for j in range(len(stmt[3])):
                    if node == stmt[3][j]:
                        substmt.insert(i, j)

    command = ["make", "print_results"]
    subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)

    read_isolation_results(True, False)

    print("[timer] Total Transform Time: " + str(TotalTransformTime))
    print("[timer] Total Compile Run Time: " + str(TotalCompileRunTime))    