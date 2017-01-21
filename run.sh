#!/bin/bash

set -e
set -x


mkdir -p /var/run/netns

BRIDGE_NAME=mpbr0
BRIDGE_MAC=00:0a:bb:cc:dd:ee

BRIDGE_IP=172.22.101.201/24
LEFT_IP=172.22.101.11/24
RIGHT_IP=172.22.101.12/24

#BRIDGE_IP=172.22.101.202/24
#LEFT_IP=172.22.101.21/24
#RIGHT_IP=172.22.101.22/24

ip link add ${BRIDGE_NAME} type bridge
ip link set ${BRIDGE_NAME} address ${BRIDGE_MAC}
ip address add ${BRIDGE_IP} dev ${BRIDGE_NAME}
ip link set dev ${BRIDGE_NAME} up



docker run -itd --net=none --name left leodotcloud/golang:1.7
docker run -itd --net=none --name right leodotcloud/golang:1.7

ln -sv /proc/$(docker inspect -f '{{.State.Pid}}' left)/ns/net /var/run/netns/left
ln -sv /proc/$(docker inspect -f '{{.State.Pid}}' right)/ns/net /var/run/netns/right

ip link add h-left type veth peer name c-left

ip link set dev h-left master ${BRIDGE_NAME}
ip link set dev h-left up


ip link set c-left netns left
ip netns exec left ip link set dev c-left name eth0
ip netns exec left ip link set eth0 up
ip netns exec left ip addr add ${LEFT_IP} dev eth0


ip link add h-right type veth peer name c-right

ip link set dev h-right master ${BRIDGE_NAME}
ip link set dev h-right up


ip link set c-right netns right
ip netns exec right ip link set dev c-right name eth0
ip netns exec right ip link set eth0 up
ip netns exec right ip addr add ${RIGHT_IP} dev eth0



