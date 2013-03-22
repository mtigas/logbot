#!/bin/bash
# precarious and awful deploy script
TEMPID="`date +\"%Y%m%d-%H%M\"`"
LOGTARBALL="logbot-${TEMPID}.tar.bz2"
SSHSERVER="ubuntu@ec2-107-20-109-216.compute-1.amazonaws.com"

# Zip up local log files
cd $HOME/Code
rm -fr /tmp/logbot
cp -r logbot /tmp/
cd /tmp/logbot
rm -fr `find . -name "*.swp" -print0 | xargs -0`
rm -fr `find . -name ".*" -print0 | xargs -0`
cd /tmp/
tar -cvjf /tmp/$LOGTARBALL logbot

# Upload & replace server log files
scp -rp "/tmp/${LOGTARBALL}" "${SSHSERVER}:/home/ubuntu/${LOGTARBALL}"
ssh ${SSHSERVER} "cd /home/ubuntu/;rm -fr logbot-old;mv logbot logs-old;tar -xjf /home/ubuntu/${LOGTARBALL};cp logbot_settings.py ./logbot/;cp s3_settings.py ./logbot/"

# Remove local tarball
rm -fr /tmp/$LOGTARBALL
