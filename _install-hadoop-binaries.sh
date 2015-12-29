#!/usr/bin/env bash

#####################
# Download and Install Hadoop binaries (on Master and Slave nodes)
cd /home/hadoopuser
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
cat >> ~/.bashrc <<\EOF
# Set hadoop environment variables, HADOOP_HOME
HADOOP_HOME=/home/hadoopuser/hadoop
# Add Hadoop bin and sbin directory to PATH
PATH=$PATH:$HADOOP_HOME/bin;$HADOOP_HOME/sbin
EOF
