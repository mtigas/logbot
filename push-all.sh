#!/bin/bash
# precarious and awful deploy script
# make sure you have "gnu-tar" installed: brew update && brew install gnu-tar
TEMPID="`date +\"%Y%m%d-%H%M\"`"
LOGTARBALL="logbot-${TEMPID}.tar.xz"
SSHSERVER="ubuntu@ec2-107-20-109-216.compute-1.amazonaws.com"

# Zip up local log files
cd $HOME/Code
rm -fr /tmp/logbot
cp -r logbot /tmp/
cd /tmp/logbot
find . -name "*.swp" -delete
find . -name ".*" -delete
cd /tmp/
gtar -cJf /tmp/$LOGTARBALL logbot

# Upload & replace server log files
scp -rp "/tmp/${LOGTARBALL}" "${SSHSERVER}:/home/ubuntu/${LOGTARBALL}"
ssh ${SSHSERVER} "cd /home/ubuntu/;rm -fr logbot-old;mv logbot logbot-old;tar -xJf /home/ubuntu/${LOGTARBALL};cp logbot_settings.py ./logbot/;cp s3_settings.py ./logbot/"

# Remove local tarball
rm -fr /tmp/$LOGTARBALL
