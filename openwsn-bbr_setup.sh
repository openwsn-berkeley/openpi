#!/bin/bash

cd /home/pi

if [ ! -d "/openwsn" ]; then
   mkdir openwsn
fi

cd openwsn


#get sw and fw from official repository + bbr fork pthubert
if [ ! -d "/openwsn-fw" ]; then
   git clone https://github.com/openwsn-berkeley/openwsn-fw.git
else
   cd openwsn-fw
   git pull
fi

if [ ! -d "/openwsn-sw" ]; then
   git clone https://github.com/openwsn-berkeley/openwsn-sw.git
else
   cd openwsn-sw
   git pull
fi

if [ ! -d "/openwsn-bbr" ]; then
   git clone https://github.com/pthubert/openwsn-sw.git openwsn-bbr
else
   cd openwsn-bbr
   git pull
fi

# update the packet list
apt-get update

# arm-gcc compiler
apt-get --assume-yes install gcc-arm-none-eabi
# setup python modules
apt-get --assume-yes install python-dev
apt-get --assume-yes install scons
apt-get --assume-yes install python-zmq
apt-get --assume-yes install python-pip
# webserver environment
pip install bottle

# eventbus environment
pip install PyDispatcher
pip install pyserial
pip install netifaces
pip install intelhex
pip install yappi
pip install openwsn-coap # to change once the coap library is on the real pypi server

# ethernet tools
apt-get --assume-yes install python-pypcap

# ohter packages
apt-get --assume-yes install ntfs-3g   # mount ntfs

# set firewall configuration and add to rc.local
sudo ip6tables -A OUTPUT -p icmpv6 --icmpv6-type destination-unreachable -j DROP

# install init.d script for openwsn-bbr (will start openwsn-bbr at startup, run sudo service openwsn-bbr start/stop/restart to start/stop/restart openwsn-bbr)
touch /etc/init.d/openwsn-bbr
echo -e $"#! /bin/sh\n# /etc/init.d/openwsn-bbr\n\n# The following part always gets executed.\n\n# The following part carries out specific functions depending on arguments.\ncase \"\$1\" in\n  start)\n    echo \"Starting openwsn-bbr\"\n    start-stop-daemon --start --oknodo --quiet --background --chdir /home/pi/openwsn/openwsn-bbr/software/openvisualizer --pidfile /var/run/openwsn-bbr.pid --make-pidfile --exec /usr/bin/scons runweb\n    echo \"openwsn-bbr is started\"\n    ;;\n  stop)\n    echo \"Stopping openwsn-bbr\"\n    pkill --signal 9 --pidfile /var/run/openwsn-bbr.pid\n    pkill --signal 9 -f 'python bin/openVisualizerApp/openVisualizerWeb.py -a /home/pi/openwsn/openwsn-bbr/software/openvisualizer/build/runui -H 0.0.0.0 -p 8080'\n    echo \"openwsn-bbr is dead\"\n    ;;\n  restart)\n    echo \"Stopping openwsn-bbr\"\n    pkill --signal 9 --pidfile /var/run/openwsn-bbr.pid\n    pkill --signal 9 -f 'python bin/openVisualizerApp/openVisualizerWeb.py -a /home/pi/openwsn/openwsn-bbr/software/openvisualizer/build/runui -H 0.0.0.0 -p 8080'\n    echo \"openwsn-bbr is dead\"\n    echo \"Starting openwsn-bbr\"\n    start-stop-daemon --start --oknodo --quiet --background --chdir /home/pi/openwsn/openwsn-bbr/software/openvisualizer --pidfile /var/run/openwsn-bbr.pid --make-pidfile --exec /usr/bin/scons runweb\n    echo \"openwsn-bbr is started\"\n    ;;\n  *)\n    echo \"Usage: /etc/init.d/openwsn-bbr {start|stop|restart}\"\n    exit 1\n    ;;\nesac\n\nexit 0\n\n\n" >> /etc/init.d/openwsn-bbr
chmod +x /etc/init.d/openwsn-bbr

sudo bash -c "head -n -1 /etc/rc.local > tmp.txt; mv tmp.txt /etc/rc.local"
sudo bash -c "echo service openwsn-bbr start >> /etc/rc.local"
sudo bash -c "echo sudo ip6tables -A OUTPUT -p icmpv6 --icmpv6-type destination-unreachable -j DROP >> /etc/rc.local"
sudo bash -c "echo exit 0 >> /etc/rc.local"
sudo chmod +x /etc/rc.local
