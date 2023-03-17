import os
import time
import sys
import subprocess
import filecmp

CleanMode = len(sys.argv) > 1 and sys.argv[1] == "clean"

def run_dir(directory, CleanMode):
    if CleanMode:
        p = subprocess.Popen(["make", "clean"], cwd=os.path.join(os.getcwd(), directory))
        return True
    else:
        p = subprocess.Popen(["python3", "../../driver/run_test.py"], cwd=os.path.join(os.getcwd(), directory))
        while p.poll() is None:
            print("================= heartbeat, running " + directory + " =================")
            time.sleep(1)

run_dir("NPB_BT", CleanMode)
run_dir("NPB_CG_S", CleanMode)
run_dir("NPB_CG_W", CleanMode)
run_dir("NPB_LU", CleanMode)
run_dir("NPB_MG", CleanMode)
run_dir("rodinia_cfd_097K", CleanMode)
run_dir("rodinia_cfd_193K", CleanMode)
run_dir("rodinia_lud", CleanMode)