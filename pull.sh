#!/bin/bash
TEMPID="`date +\"%Y%m%d-%H%M\"`"
LOGTARBALL="logs-${TEMPID}.tar.bz2"
SSHSERVER="ubuntu@ec2-107-20-109-216.compute-1.amazonaws.com"

# Zip up remote log files
ssh ${SSHSERVER} "cd /home/ubuntu/logbot;tar -cvjf /home/ubuntu/${LOGTARBALL} logs"
scp -rp "${SSHSERVER}:/home/ubuntu/${LOGTARBALL}" "/tmp/${LOGTARBALL}"

cd $HOME/Code/logbot
tar -xjf /tmp/$LOGTARBALL logs

# Upload & replace server log files

# Remove local tarball
rm -fr /tmp/$LOGTARBALL
