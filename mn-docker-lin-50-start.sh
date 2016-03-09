#!/bin/bash

host=`hostname -i`
docker run -it --privileged barbaracollignon/ubuntu-mininet /bin/bash -c "service openvswitch-switch start;mn --controller=remote,ip=$host,port=6633 --topo=linear,50 --switch=ovsk,protocols=OpenFlow13 --mac"
