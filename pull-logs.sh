#!/bin/bash
TEMPID="`date +\"%Y%m%d-%H%M\"`"
LOGTARBALL="logs-${TEMPID}.tar.xz"
SSHSERVER="ubuntu@ec2-107-20-109-216.compute-1.amazonaws.com"

# Zip up remote log files
ssh ${SSHSERVER} "cd /home/ubuntu/logbot;tar -cJf /home/ubuntu/${LOGTARBALL} logs"
scp -rp "${SSHSERVER}:/home/ubuntu/${LOGTARBALL}" "/tmp/${LOGTARBALL}"

cd $HOME/Code/logbot
tar -xJf /tmp/$LOGTARBALL

# Upload & replace server log files

# Remove local tarball
rm -fr /tmp/$LOGTARBALL
