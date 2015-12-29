#!/usr/bin/env bash

THE_GROUP_NAME=hadoopgroup
HD_USER=hadoopuser

#####################
# Download and Install Hadoop binaries (on Master and Slave nodes)
cd /home/$HD_USER
wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz
tar xvf hadoop-2.6.3.tar.gz
mv hadoop-2.6.3 hadoop

# wget http://apache.fayea.com/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz 
# wget http://apache.opencas.org/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz 
# wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz 
# wget http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz 
# wget http://mirrors.noc.im/apache/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz 


#####################
# Set hadoop environment variables
cat >> /home/$HD_USER/.bashrc <<EOF
# Set hadoop environment variables, HADOOP_HOME
export HADOOP_HOME=/home/$HD_USER/hadoop
# Add Hadoop bin and sbin directory to PATH
export PATH=\$PATH:\$HADOOP_HOME/bin;\$HADOOP_HOME/sbin
EOF
source /home/$HD_USER/.bashrc


#####################
# Create neccessary directries:
THE_PATH_ROOT=/hadoop-data
# This directory is used by Namenode to store its metadata file. (on master and slave node)
sudo mkdir -p $THE_PATH_ROOT/$HD_USER/hdfs/namenode/
# This directory is used by Datanode to store hdfs data blocks. (on master and slave node)
sudo mkdir -p $THE_PATH_ROOT/$HD_USER/hdfs/datanode/
# Change the dir ownner to hd user:
sudo chown -R $HD_USER:$THE_GROUP_NAME $THE_PATH_ROOT
