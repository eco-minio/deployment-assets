#!/bin/bash

# Remind users to set up passwordless ssh, clush and visudo

echo "Before running this script, you need to set up passwordless ssh and create a clush hosts file in /home/$USER/minio-nodes. You will also need to copy the minio.license into this folder"

# Install ancillary packages 
# Make sure to run bootstrap.sh on the primary node to install needed packages
clush --hostfile /home/$USER/minio-nodes sudo apt install sysstat iperf tmux vim

# Download AIStor components
wget https://dl.min.io/aistor/mc/release/linux-amd64/mc
wget https://dl.min.io/aistor/minio/release/linux-amd64/minio
#wget https://dl.min.io/aistor/minkms/release/linux-amd64/minkms
#wget https://dl.min.io/aistor/minwall/release/linux-amd64/minwall
#wget https://dl.min.io/aistor/mincat/release/linux-amd64/mincat

# Download benchmarking tools 
#wget https://github.com/minio/hperf/releases/latest/download/hperf-linux-amd64 -O hperf
#wget https://github.com/minio/dperf/releases/latest/download/dperf-linux-amd64 -O dperf

# Since warp has no direct link, use this monstrosity  -- it almost certainly will break in the future
#wget https://github.com/minio/warp/releases/download/$(curl https://github.com/minio/warp/releases/ | grep tree | grep -v script | head -n1 |cut -b 33-38)/warp_Linux_x86_64.tar.gz

# Unpack warp
#tar -xvzf warp_Linux_x86_64.tar.gz

# Make binaries executable
chmod +x mc minio minkms minwall mincat hperf dperf warp

# Create assets temp dir
clush --hostfile /home/$USER/minio-nodes mkdir /home/$USER/assets

# Copy assets to remote nodes
clush --hostfile /home/$USER/minio-nodes --copy . --dest /home/$USER/assets

# Make generic asset / config dir for minio
clush --hostfile /home/$USER/minio-nodes sudo mkdir /etc/minio

# Copy systemd service files
clush --hostfile /home/$USER/minio-nodes sudo cp /home/$USER/assets/*service /etc/systemd/system/

# Copy binaries to $PATH
clush --hostfile /home/$USER/minio-nodes sudo cp  /home/$USER/assets/warp /home/$USER/assets/dperf /home/$USER/assets/hperf /home/$USER/assets/mc /home/$USER/assets/minio /home/$USER/assets/minkms /home/$USER/assets/minwall /home/$USER/assets/mincat /usr/local/bin

# Copy config files to generic location
clush --hostfile /home/$USER/minio-nodes  sudo cp /home/$USER/assets/*config /home/$USER/assets/public.crt /home/$USER/assets/private.key /home/$USER/assets/minio.license /etc/minio/


# Grafana setup 
# TODO

# Prometheus setup
# TODO

# tuned setup
# TODO

# SUBNET diag steps
# TODO
# Disable audit
# Disable iommu
# Disable updatedb
# Ensure performance governor for i/o

