#!/bin/bash

# Unregister and register the VM
subscription-manager clean
subscription-manager register --activationkey=12-5-22-instruqt --org=12451665 --force

# This setup is a no-op, no original setup needed
echo "DONE" >> /root/post-run.log
