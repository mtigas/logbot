#!/usr/bin/env python
# coding=utf-8
#
# s3dir.py
# Extensions to `s3up.py` to recursively upload a directory to S3.
# Copyright (c) 2010-2012 Mike Tigas <mike@tig.as>
# http://mike.tig.as/
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
import sys

import traceback
import os
import s3up
from boto.s3.connection import S3Connection
from socket import setdefaulttimeout
setdefaulttimeout(100.0)

def update_irc():
    upload_dir("/home/ubuntu/logbot/logs/#opennews",'','opennews-irc.yu8.in', 'http://opennews-irc.yu8.in/')

def upload_dir(local_dir,remote_dir,bucket,bucket_url=None):
    for root, dirs, files in os.walk(local_dir):
        for f in files:
            fullfile = os.path.join(root, f).strip()
            remotefile = fullfile.replace(local_dir,'').strip()
            if remote_dir:
                remotefile = remote_dir+"/"+remotefile
            if remotefile[0] == "/":
                remotefile = remotefile[1:]
            if (remotefile.find('.svn') == -1) and \
                (remotefile.find('.svn-base') == -1) and \
                (remotefile.find('.DS_Store') == -1) and \
                (remotefile.find('.pyo') == -1) and \
                (remotefile.find('.pyc') == -1):
                    s3up.upload_file(fullfile,bucket,remotefile)
                    if not bucket_url:
                        print "https://s3.amazonaws.com/%s/%s" % (bucket,remotefile)
                    else:
                        print "%s%s" % (bucket_url,remotefile)

def main(args):
    update_irc()

if __name__ == '__main__':
    try:
        main(sys.argv[1:])
    except Exception, e:
        sys.stderr.write('\n')
        traceback.print_exc(file=sys.stderr)
        sys.stderr.write('\n')
        print sys.argv[1:]
        sys.exit(1)
