import os
import sys
stream1 = os.popen(
    'conda run -n base python detect.py --weights yolov5s.pt --img 640 --conf 0.25 --source data/images')
output = stream1.read()
print(output)
