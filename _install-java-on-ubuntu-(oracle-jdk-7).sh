#!/usr/bin/env bash
####################
# To install jdk on ubuntu
# x
# jdk-6u31-linux-i586.bin
# http://www.oracle.com/technetwork/java/javase/index.html
# http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
####################

# 1. Install packages
sudo apt-get -y --force-yes install python-software-properties debconf-utils
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get -y --force-yes install oracle-java7-installer

# Updata Java runtime
sudo update-java-alternatives -s java-7-oracle


# # 2. Set Java environment variables:
# sudo update-alternatives --config java

# sudo su -c cat >> /etc/environment << EOF
# JAVA_HOME=/usr/lib/jvm/java-7-oracle
# CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
# PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
# EOF

cat >> ~/.bashrc <<\EOF
# Set Java environment variables
JAVA_HOME=/usr/lib/jvm/java-7-oracle
CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
EOF

# 3. Verifying
java -version

#####################
# export JAVA_HOME=/usr/java/jdk1.6.0_31
# export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
# export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
# source /etc/profile
# java -version
# sudo update-alternatives --config java
# sudo update-alternatives --config javac

# echo 'PGSYSCONFDIR=“/etc:/var/lib"' >> /etc/environment
# sudo cat >> /etc/environment << EOF
# JAVA_HOME="/etc:/var/lib"
# EOF
