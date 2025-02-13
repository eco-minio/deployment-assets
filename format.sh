#!/bin/bash

# Format hdd 
# List of values to map to physical devices
#a=(c d e f g h i j k l m n);
# List of values to map to drive LABEL 
#b=(1 2 3 4 5 6 7 8 9 10 11 12 );
#for i in ${!a[@]}; do mkfs.xfs -f -L drive${b[i]} /dev/sd${a[i]};
#done


# Format nvme with fstab output
# List of values to map to physical devices
# a=(0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16);
# List of values to map to drive LABEL
# b=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 );

devices=($(lsblk -J -o NAME,SIZE,ROTA,TYPE,MODEL,MOUNTPOINTS | jq -r '.blockdevices[] | select(.type == "disk" and (.children | length == 0)) | .name'))

for i in ${!devices[@]} 
do 
    sudo mkdir -p /mnt/minio-data$((i+1))
    sudo mkfs.xfs -f -L minio-data$((i+1)) /dev/${devices[i]}
    echo "LABEL=minio-data$((i+1)) /mnt/minio-data$((i+1))  xfs     defaults,noatime        0 0"
done
