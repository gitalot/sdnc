#!/bin/bash
docker run -it --privileged gilyav/mininet /bin/bash -c "service openvswitch-switch start;mn --controller=none --switch=ovs -i 10.0.3.0 --topo torus,3,3"
