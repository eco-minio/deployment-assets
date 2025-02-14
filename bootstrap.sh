#!/bin/bash
# Install needed packages for monitoring, deploying packages etc
sudo apt install clustershell git prometheus prometheus-process-exporter 
echo "Please create a newline separated list of nodes in /home/$USER/minio-nodes. You will need to set up passwordless ssh and sudo on all nodes (including $SELF) before running minio-init.sh"

# Install grafana
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.5.1_amd64.deb
sudo dpkg -i grafana-enterprise_11.5.1_amd64.deb

