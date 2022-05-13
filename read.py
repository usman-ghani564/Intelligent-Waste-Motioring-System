import sys
import os
import glob

value = sys.argv[2]
choice = int(sys.argv[1])


def yolov5_detect():
    stream1 = os.popen(
        'conda run -n base python detect.py --save-txt --save-conf --weights best.pt --img 640 --conf 0.25 --source testimg')
    output = stream1.read()
    print(output)
    sys.stdout.flush()


def get_confidence():
    list_of_dirs = glob.glob('runs/detect/*')  # * means all if need specific format then *.csv
    latest_dir = max(list_of_dirs, key=os.path.getctime)

    pp = "D:/Haris/Job/Projects/Air-Quality-Project-3/yolov5/runs/detect/" + latest_dir[12:] + "/labels"

    dirp = os.listdir(pp)

    flag = True
    # Checking if the list is empty or not
    if len(dirp) == 0:
        flag = False

    if flag == True:
        for root, dirs, files in os.walk(latest_dir):
            for name in files:
                if name.endswith((".txt")):
                    x = name

        x = "D:/Haris/Job/Projects/Air-Quality-Project-3/yolov5/runs/detect/" + latest_dir[12:] + "/labels/" + x

        confidence = 0

        with open(x, "r") as file1:
            for line in file1.readlines():
                y = line.split(' ')
                confidence = float(y[-1])

        thres_hold = 0.70
        if confidence >= thres_hold:
            print(1)
            sys.stdout.flush()
        else:
            print(0)
            sys.stdout.flush()
    else:
        print(0)
        sys.stdout.flush()


def del_files():
    path = r"D:\Haris\Job\Projects\Air-Quality-Project-3\yolov5\testimg\\"
    for file_name in os.listdir(path):
        # construct full file path
        file = path + file_name
        if os.path.isfile(file):
            os.remove(file)
    print('deleting files successful!')
    sys.stdout.flush()


def rename_img():
    old_name = r"D:\Haris\Job\Projects\Air-Quality-Project-3\yolov5\testimg\imageName"
    new_name = r"D:\Haris\Job\Projects\Air-Quality-Project-3\yolov5\testimg\img.jpg"

    if os.path.isfile(new_name):
        print("The file already exists")
    else:
        # Rename the file
        os.rename(old_name, new_name)

    print('Rename File successful!')
    sys.stdout.flush()


if __name__ == "__main__":
    if choice == 0:
        yolov5_detect()
    elif choice == 1:
        get_confidence()
    elif choice == 2:
        rename_img()
    elif choice == 3:
        del_files()
