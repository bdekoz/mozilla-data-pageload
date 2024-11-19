#!/usr/bin/env python

# run like:
# /generate_json_by_date_for_display.py 1 2 3 4 5

import sys
import os
import subprocess
import json
from pathlib import Path

# setup input file, output file naming conventions
testnp = sys.argv[1];
datestr = sys.argv[2];
sxsvi = sys.argv[3];
fjsn = sys.argv[4];
cjsn = sys.argv[5];


#
def serialize_consolidated(tnameplatform, date, sbys_video, jfirefox, jchrome):
    vdict = {"test" : tnameplatform }
    vdict["date"] = date
    vdict["side_by_side_video"] = sbys_video
    with open(jfirefox, 'r') as jf:
      firefox_dict = json.load(jf)
      vdict["firefox"] = firefox_dict
    with open(jchrome, 'r') as jc:
      chrome_dict = json.load(jc)
      vdict["chrome"] = chrome_dict
    ofname = date + "-" + tnameplatform + "-" + "consolidated.json"
    with open(ofname, 'w') as of:
        json.dump(vdict, of, indent=2)

serialize_consolidated(testnp, datestr, sxsvi, fjsn, cjsn)
