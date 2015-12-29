#!/usr/bin/env bash

######: Start with params
# shell script for hd-master
HD_MASTER_ADDRESS=192.168.3.2
HD_USER=hadoopuser
CURRENT_NODE_ADDRESS=192.168.3.2
CURRENT_NODE_NAME=hd-master

######: Install packages
# Install: basic, for auto-typein ssh password
sudo apt-get -y --force-yes install sshpass

######: Set linux user password
echo -e "a\na\n" | sudo passwd $HD_USER


######: 
# Set up trusted copy between the servers
# 所有的Slave都在clone时把自己的key提交到master，同时把master上的数据复制到slave.local
sudo su - $HD_USER -c sh <<EOF
# Generate a new RSA-keypair, # ssh-copy-id -i ~/.ssh/id_rsa.pub <slave hostname>
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
chmod 740 .ssh/

# Adding authorized_keys, cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sshpass -p 'a' ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub $HD_MASTER_ADDRESS

# Adding known_hosts, ssh-keyscan -H $HD_MASTER_ADDRESS | sudo tee ~/.ssh/known_hosts
sshpass -p 'a' ssh -o StrictHostKeyChecking=no $HD_USER@$HD_MASTER_ADDRESS
EOF


# key file change notification
# after other slave updated the (authorized_keys & known_hosts), master need to push these 2 files to all other slave
sudo apt-get install incron
sudo cat > /etc/incron.allow <<EOF
$HD_USER
EOF
sudo chmod 777 /var/spool/incron/
cat > ~/temp-incron-tab.conf <<EOF
/home/$HD_USER/.ssh IN_MODIFY,IN_CLOSE_WRITE sh /home/$HD_USER/icron-job-key-change-notification.conf
EOF
sudo incrontab -u $HD_USER ~/temp-incron-tab.conf
sudo rm ~/temp-incron-tab.conf
sudo service incron restart
