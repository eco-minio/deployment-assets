#!/bin/bash

# Generate list of devices to format. This script is ***DANGEROUS*** and should not be used without confirming no unexpected devices are in the list, e.g. /
devices=($(lsblk -J -o NAME,SIZE,ROTA,TYPE,MODEL,MOUNTPOINTS | jq -r '.blockdevices[] | select(.type == "disk" and (.children | length == 0)) | .name'))

# Create mount point paths and format drives
for i in ${!devices[@]} 
do 
    sudo mkdir /mnt/minio-data${i}
    sudo mkfs.xfs -f -L minio-data${i} /dev/${devices[i]}
done

# Output fstab entries
for i in ${!devices[@]}
do 
    echo "LABEL=minio-data${i} /mnt/minio-data${i}  xfs     defaults,noatime        0 0"
done
