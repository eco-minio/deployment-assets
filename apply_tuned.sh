#!/bin/bash

# Make sure tuned is installed on the system
sudo apt install tuned

# Grab MinIO tuned config
wget https://raw.githubusercontent.com/minio/minio/master/docs/tuning/tuned.conf -O /tmp/tuned.conf


# Create a folder in the tuned path then move config there
sudo mkdir -p /usr/lib/tuned/minio/
sudo mv /tmp/tuned.conf /usr/lib/tuned/minio

# Apply the profile
sudo tuned-adm profile minio

