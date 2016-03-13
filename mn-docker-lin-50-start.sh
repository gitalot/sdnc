#!/bin/bash
sudo modprobe openvswitch
host=`ifconfig docker0 |xargs|awk '{print $7}'|sed -e 's/[a-z]*:/''/'`
docker run -it --privileged barbaracollignon/ubuntu-mininet /bin/bash -c "service openvswitch-switch start;mn --controller=remote,ip=$host,port=6633 --topo=linear,50 --switch=ovsk,protocols=OpenFlow13 --mac"
