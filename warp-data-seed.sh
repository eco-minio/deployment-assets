#!/bin/bash

# Pre-seed data for warp runs using  with GET and --noclear. 

for op in get ; do
        for size in  100MiB 10MiB 10KiB;  do
                for conc in 80; do
            flags="--noclear --objects 500000"

            echo "Using flags: ${flags}";
        warp ${op} --warp-client=minio{1...4}   \
                 --bucket warp-bench \
                 --prefix objsize-${size}-threads-${conc}/ \
                 --obj.generator random \
                 --region us-east-1 \
                 --access-key=minioadmin \
                 --secret-key=minioadmin \
                 --obj.size=${size} \
                 --concurrent=${conc} \
                 --duration 10s \
                 --benchdata obj-data-seed-${size}-threads-${conc}-${op} \
                 ${flags} | tee obj-data-seed${size}-threads-${conc}-${op}.log

        done;
    done;
  done

