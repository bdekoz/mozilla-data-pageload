#!/usr/bin/env python

# run like:
# /generate_video_thumbnails_standalone.py video.mp4

import sys
import os
import subprocess
from pathlib import Path

# setup input file, output file naming conventions
ifile = sys.argv[1];
filename = Path(ifile);
filenamebase = os.path.splitext(filename)[0]
print("input file: ", ifile)

# find duration of input video file
def video_duration(ivideo):
    result = subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'default=noprint_wrappers=1:nokey=1', ivideo], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return float(result.stdout)

dursec=video_duration(ifile)
print("duration in seconds: ", dursec)


# Extract frame from video stream at specified points.
# Either pick a set number of result thumbnails (say 12) spaced discretely over entire duration
# or an offset from the beginning given an interval in seconds (250ms = .25s)

# from
# https://tinyurl.com/32m4ywhx

# "This example will seek to the position of 0h:0m:14sec:435msec and
# output one frame (-frames:v 1) from that position into a PNG file.

#ffmpeg -i input.flv -ss 00:00:14.435 -frames:v 1 out.png

def generate_video_thumbnail_partition_n(ivideo, totaln):
    cspace = ' '
    for i in range(totaln):
        print(i)
        timecoden = (i/totaln) * dursec
        if timecoden < 60:
            thumbflag = "-ss 00:00:" + str(timecoden) + cspace + "-frames:v 1"
        else:
            timecodemin = int(timecoden/60)
            timecodesec = timecoden - timecodemin;
            thumbflag = "-ss 00:" + str(timecodemin) + ":" + str(timecodesec) + cspace + "-frames:v 1"
        ofname = f"{filenamebase}_{i:02d}.png"
        fcommand="ffmpeg -i " + ifile + cspace + thumbflag + cspace + ofname
        #print(str(timecoden) + cspace + fcommand)
        os.system(fcommand)


# intervaln is in seconds, so 500 ms would be .5         
def generate_video_thumbnail_interval(ivideo, intervaln):
    cspace = ' '
    totaln = int(dursec / intervaln)
    offset = intervaln;
    for i in range(totaln):
        print(i)
        timecoden = offset + (intervaln * i);
        if timecoden < 60:
            thumbflag = "-ss 00:00:" + str(timecoden) + cspace + "-frames:v 1"
        else:
            timecodemin = int(timecoden/60)
            timecodesec = timecoden - timecodemin;
            thumbflag = "-ss 00:" + str(timecodemin) + ":" + str(timecodesec) + cspace + "-frames:v 1"
        ofname = f"{filenamebase}_{timecoden}.png"
        fcommand="ffmpeg -i " + ifile + cspace + thumbflag + cspace + ofname
        print(str(timecoden) + cspace + fcommand)
        #os.system(fcommand)
        


#generate_video_thumbnail_partition_n(ifile, 12)
generate_video_thumbnail_interval(ifile, 0.25)
