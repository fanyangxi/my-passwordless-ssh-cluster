#!/usr/bin/env bash
####################
# Hadoop talks to other nodes in the cluster using no-password ssh.
# By having Hadoop run under a specific user context, it will be easy 
# to distribute the ssh keys around in the Hadoop cluster. 
####################

# Create hadoop group
THE_GROUP_NAME=hadoopgroup
if grep -q $THE_GROUP_NAME /etc/group; then
    echo "Group already exists"
else
    # echo "Group does not exist"
    echo "Creating new group: $THE_GROUP_NAME"
    sudo addgroup $THE_GROUP_NAME
fi

# Create hadoop user
THE_USER_NAME=hadoopuser
THE_USER_PASSWORD=a
if id -u "$THE_USER_NAME" >/dev/null 2>&1; then
    echo "User already exists"
else
    # echo "User does not exist"
    echo "Creating new user: $THE_USER_NAME"
    sudo useradd $THE_USER_NAME -s /bin/bash -m -g $THE_GROUP_NAME -G $THE_GROUP_NAME
    echo $THE_USER_NAME:$THE_USER_PASSWORD | sudo chpasswd

    # add user to root group
    sudo usermod -a -G sudo $THE_USER_NAME
    # # remove
    # sudo usermod -G $THE_GROUP_NAME $THE_USER_NAME
fi

# # Login as hadoopuser
# su - hadoopuser

# sudo adduser -ingroup $THE_GROUP_NAME $THE_USER_NAME
# sudo adduser $THE_USER_NAME --gecos "Yangxi Fan,01" --disabled-password
# sudo su -c "useradd $THE_USER_NAME -s /bin/bash -m -g $THE_GROUP_NAME -G $THE_GROUP_NAME"
# sudo adduser myuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
# echo "myuser:password" | sudo chpasswd
