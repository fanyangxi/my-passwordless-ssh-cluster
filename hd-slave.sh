#!/usr/bin/env bash

######: Start with params
# shell script for hd-slave
HD_MASTER_ADDRESS=192.168.3.2
CURRENT_NODE_ADDRESS=192.168.3.21
CURRENT_NODE_NAME=hd-slave-1

######: Install packages
# Install: basic, for auto-typein ssh password
sudo apt-get -y --force-yes install sshpass

######: Set linux user password
echo -e "a\na\n" | sudo passwd vagrant

# if id -u "$1" >/dev/null 2>&1; then
#     echo "user exists"
# else
#     echo "user does not exist"
# fi


######: 
# Set up trusted copy between the servers
# One option at this point, to setup public key authentication, would be to repeat the steps as we
# did for root. 
sudo su - vagrant -c sh <<EOF
# generate a new RSA-keypair, # ssh-copy-id -i ~/.ssh/id_rsa.pub <slave hostname>
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""

# remote-adding authorized_keys: add the generated public keys of current slave to master ~/.ssh/authorized_keys
sshpass -p 'a' ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub $HD_MASTER_ADDRESS

# remote-adding known_hosts, ssh-keyscan -H 192.168.3.12 | sudo tee ~/.ssh/known_hosts
# sshpass -p 'a' ssh -t vagrant@$HD_MASTER_ADDRESS "sshpass -p 'a' ssh -o StrictHostKeyChecking=no vagrant@$CURRENT_NODE_ADDRESS"
sshpass -p 'a' ssh -o StrictHostKeyChecking=no -t vagrant@$HD_MASTER_ADDRESS "sshpass -p 'a' ssh-keyscan -H $CURRENT_NODE_ADDRESS | tee -a ~/.ssh/known_hosts"

# Grab public-key-authentication-files from Master (.ssh)
sshpass -p 'a' scp -o StrictHostKeyChecking=no -r $HD_MASTER_ADDRESS:~/.ssh/{authorized_keys,known_hosts} ~/.ssh
EOF

# register key-file change notification
# after other slave updated the (authorized_keys & known_hosts), master need to push these 2 files to all other slave
sudo su - vagrant -c "
sshpass -p \'a\' ssh -o StrictHostKeyChecking=no -t vagrant@$HD_MASTER_ADDRESS \"
cat >> $HOME/icron-job-key-change-notification.conf <<\EOFcat
sshpass -p 'a' scp -o StrictHostKeyChecking=no -r $HOME/.ssh/authorized_keys $HOME/.ssh/known_hosts $CURRENT_NODE_ADDRESS:$HOME/.ssh
EOFcat
\"
"
