#!/bin/bash

apt install -y xfsprogs

umount /mnt
sed -i '/xvdb/d' /etc/fstab


for DEVICE in {b..g};
do
  echo "making xfs on device $DEVICE"
  mkfs.xfs -K /dev/xvd${DEVICE}
done

echo "Done making XFS"
echo

for i in {0..5}
do
  echo "making mount point ${i}"
  mkdir -p /grid/${i}
done
echo "Done making mount points"


GRID=0
for DEVICE in {b..g};
do
  echo "adding entry to fstab for device $DEVICE"
  echo "/dev/xvd${DEVICE} /grid/${GRID} xfs noatime,nodiratime 1 2" >> /etc/fstab

  GRID=$((GRID+1))
done
echo "Done adding fstab entries"
echo
echo "Mount all XFS"

mount -a

echo "DONE mounting all devices"
cat /etc/fstab

echo
df -h

