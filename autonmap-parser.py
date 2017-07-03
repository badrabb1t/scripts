#!/usr/bin/env python2
# companion tool for autonmap.sh
# enables quick listing of machines running specified port or protocol
#
# Usage: autonmap-parser.py <port or protocol>
# Note: must be run from same directory as autonmap.sh
# @badrabb1t 

import os
import sys
import re

# read the data from each scan
for x in os.walk('.'):
  file = str(x[0])[2:] + '/nmap-tcp.nmap'
  if not file.startswith('/nmap-tcp'):
    f = open(file, 'r')
    data = f.read().splitlines()
    fname = re.sub(r'/.*$','',file)

    # check each line for user's argument
    # omit files with no matches
    matchcount = 0
    lines = []
    for line in data:
      # check only lines showing an open port
      if 'open' in line:
        if str(sys.argv[1]) in line:
          matchcount += 1
          lines.append(line)
    if matchcount != 0:
      print '\n' + fname
      for i in lines:
        print i
