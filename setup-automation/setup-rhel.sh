#!/bin/bash

# Unregister and register the VM
dnf -y remove katello-ca-consumer-*
subscription-manager clean
subscription-manager register --activationkey=$ACTIVATION_KEY --org=$ORG_ID --force

# Install required packages
dnf install -y nfs-utils

# Start rhsm service
systemctl start rhsm.service

echo "DONE" >> /root/post-run.log
