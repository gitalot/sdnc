#!/bin/bash

host=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' sdnc`
if [ -z "$host" ]; then
    echo "Can't find ip for sdn container. Exit."
    exit -1
fi

sudo modprobe openvswitch
docker run -it --privileged barbaracollignon/ubuntu-mininet /bin/bash -c "service openvswitch-switch start;mn --controller=remote,ip=$host,port=6653 --topo=linear,50 --switch=ovsk,protocols=OpenFlow13 --mac"
