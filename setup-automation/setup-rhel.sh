#!/bin/bash
set -euxo pipefail
# Create an output file
touch /root/post-run.log

# Create a done file to signal we have finished
touch /root/post-run.log.done

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

#set up tmux so it has to restart itself whenever the system reboots

#step 1: make a script
tee ~/startup-tmux.sh << EOF
TMUX='' tmux new-session -d -s 'rhel-session' > /dev/null 2>&1
TMUX='' tmux new-session -d -s 'rhel-session-2' > /dev/null 2>&1
tmux set -g pane-border-status top
tmux setw -g pane-border-format ' #{pane_index} #{pane_current_command}'
tmux set -g mouse on
tmux set mouse on
EOF

#step 2: make it executable
chmod +x ~/startup-tmux.sh
#step 3: use cron to execute 
echo "@reboot ~/startup-tmux.sh" | crontab -

#step 4: start tmux for the lab
~/startup-tmux.sh

echo "DONE" >> /root/post-run.log