#!/usr/bin/env bash
###################
# To disable ipv6 on ubuntu
# http://askubuntu.com/questions/440649/how-to-disable-ipv6-in-ubuntu-14-04
###################


sudo -u root sh <<EOF
sudo cat >> /etc/sysctl.conf << EOFCat
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOFCat
EOF

sudo sysctl -p


###################
# sudo touch /etc/sysctl.d/bindv6only.conf
# sudo sed -i 's/net.ipv6.bindv6only\ =\ 1/net.ipv6.bindv6only\ =\ 0/' \
# /etc/sysctl.d/bindv6only.conf && sudo invoke-rc.d procps restart
