#!/bin/bash

echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

sysctl -w "net.core.somaxconn=16384"

# backlog before dropping packets
sysctl -w "net.core.netdev_max_backlog=20000" 

# Max amount of read/write buffers that can be set via setSockOpt/client side
sysctl –w "net.core.rmem_max = 134217728"
sysctl –w "net.core.wmem_max = 134217728"

# Default read/write buffers set by kernel
sysctl –w "net.core.rmem_default = 524288"
sysctl –w "net.core.wmem_default = 524288"

# min/start/max. even if 30K connections are there in the node, 30K * 64KB ~ 2 GB?. Should be fine in machine with large RAM.
sysctl -w "net.ipv4.tcp_rmem=4096 65536 134217728"
sysctl -w "net.ipv4.tcp_wmem=4096 65536 134217728"
sysctl -w "net.ipv4.ip_local_port_range =5000 61000"

# Change ethX to relevant nic
sysctl -w "net.ipv4.conf.ethX.forwarding=0" 

sysctl -w "net.ipv4.tcp_mtu_probing=1"
sysctl -w "net.ipv4.tcp_fin_timeout=25"
sysctl -w "net.ipv4.conf.lo.forwarding=0"
sysctl -w "vm.dirty_background_ratio=80"
sysctl -w "vm.dirty_ratio=80"
sysctl -w "vm.swappiness=1"

