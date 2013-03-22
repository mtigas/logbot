#!/bin/bash
TEMPID="`date +\"%Y%m%d-%H%M\"`"
LOGTARBALL="logs-${TEMPID}.tar.bz2"
SSHSERVER="ubuntu@ec2-107-20-109-216.compute-1.amazonaws.com"

# Zip up local log files
cd $HOME/Code/logbot
tar -cvjf /tmp/$LOGTARBALL logs

# Upload & replace server log files
scp -rp "/tmp/${LOGTARBALL}" "${SSHSERVER}:/home/ubuntu/${LOGTARBALL}"
ssh ${SSHSERVER} "cd /home/ubuntu/logbot/;rm -fr ../logs-old;mv logs ../logs-old;tar -xjf /home/ubuntu/${LOGTARBALL}"

# Remove local tarball
rm -fr /tmp/$LOGTARBALL
