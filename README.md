# my-passwordless-ssh-cluster

To set up a passwordless SSH for communication between nodes in a cluster.
Init your master node with the script first, and then each time you init a new slave node, the script will do the work to set passwordless ssh communication for all the servers.

### Intro:

The scripts have been tested with vagrant, on ubuntu 14.04. 
- 1. vagrant up your master node, with a shell provision points to hd-master.sh
- 2. vagrant up the other slave nodes, with a shell provision points to hd-slave.sh (The CURRENT_NODE_ADDRESS param needs to be updated accordingly)

### After processing:
- The password of linux user vagrant will be set to 'a', on both master and slave nodes.
- *Known Issue*: You must manually type in the password 'a' when you try to 'vagrant ssh' the slave node. This's because the original authorized_keys file has been replaced on slave nodes.

