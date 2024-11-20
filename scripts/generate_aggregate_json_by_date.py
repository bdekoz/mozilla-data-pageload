#!/usr/bin/env python

# run like:
# generate_aggregate_json_by_date.py 1 2 3 4 5

import sys
import os
import subprocess
import json
from pathlib import Path

# setup input file, output file naming conventions
testnp = sys.argv[1];
datestr = sys.argv[2];
sxsvi = sys.argv[3];
fjsnfilm = sys.argv[4];
fjsnmetric = sys.argv[5];
cjsnfilm = sys.argv[6];
cjsnmetric = sys.argv[7];


# Consolidate per-date and platform data files into one file.
# json for filmstrips, json for metrics
def serialize_aggregate(tnameplatform, date, sbys_video,
                           flmfirefoxj, mtrxfirefoxj, flmchromej, mtrxchromej):
    vdict = {"test" : tnameplatform }
    vdict["date"] = date
    vdict["side_by_side_video"] = sbys_video
    with open(flmfirefoxj, 'r') as jf:
      firefox_dict = json.load(jf)
      with open(mtrxfirefoxj, 'r') as jfm:
          firefoxm_dict = json.load(jfm)
          firefox_dict["metrics"] = firefoxm_dict
      vdict["firefox"] = firefox_dict
    with open(flmchromej, 'r') as jc:
      chrome_dict = json.load(jc)
      with open(mtrxchromej, 'r') as jcm:
          chromem_dict = json.load(jcm)
          chrome_dict["metrics"] = chromem_dict
      vdict["chrome"] = chrome_dict
    ofname = date + "-" + tnameplatform + "-" + "aggregate.json"
    with open(ofname, 'w') as of:
        json.dump(vdict, of, indent=2)

serialize_aggregate(testnp, datestr, sxsvi, fjsnfilm, fjsnmetric,
                       cjsnfilm, cjsnmetric)
