#!/bin/bash
docker run -it --privileged gilyav/mininet /bin/bash -c "service openvswitch-switch start;mn --controller=none --switch=user -i 10.0.4.0 --mac --topo tree,depth=3,fanout=2"
