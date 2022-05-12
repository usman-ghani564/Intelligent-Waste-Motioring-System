import glob
import os

list_of_dirs = glob.glob('runs/detect/*')  # * means all if need specific format then *.csv
latest_dir = max(list_of_dirs, key=os.path.getctime)

for root, dirs, files in os.walk(latest_dir):
    for name in files:
        if name.endswith((".txt")):
            x = name

x = "D:/Haris/Job/Projects/Air-Quality-Project-3/yolov5/runs/detect/" + latest_dir[12:] + "/labels/" + x

confidence = 0

with open(x, "r") as file1:
    for line in file1.readlines():
        # f_list = [float(i) for i in line.split(",") if i.strip()]
        # T += f_list[7:11]
        y = line.split(' ')
        confidence = float(y[-1])

thres_hold = 0.70
if confidence >= thres_hold:
    print(1)
else:
    print(0)

# for i in data:
#     print(i + "\n")
