import os
import time
import sys
import subprocess

count = 0

if __name__ == "__main__":
    cleanMode = True
    if len(sys.argv) < 2:
        cleanMode = False

    startDir = "prog_1"
    if os.path.exists("progress.txt"):
        with open("progress.txt", "r") as f:
            startDir = f.readline().strip()

    startDirFound = False

    for root, dirs, files in os.walk("./"):
        count = 0
        total = len(dirs)
        print(sorted(dirs))
        for name in sorted(dirs, key=str):
            if not "prog_" in name:
                continue
            index = int(name.split("_")[1])    
            if cleanMode == False and startDirFound == False and name != startDir:
                continue

            startDirFound = True

            print("running in " + name)

            if cleanMode:
                origPath = os.getcwd()
                os.chdir(os.path.join(root, name))
                os.system("mv results.out results.txt")
                os.system("mv signature.out signature.txt")
                os.system("make clean")
                os.chdir(origPath)            
            else: #if index in locList:            
                p = subprocess.Popen(["python3", "../../driver/run_test.py", os.path.join(root, name)], cwd=os.path.join(root, name))

                while p.poll() is None:
                    print("================= heartbeat, running " + name + " (" + str(count) + "/" + str(total) + ") =================")
                    time.sleep(1)

                with open("progress.txt", "w") as f:
                    f.write(name + "\n")
            count += 1
        
        break