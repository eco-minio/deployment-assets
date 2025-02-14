#!/bin/bash

# Pre-seed data for warp runs using  with GET and --noclear. Total object count created will vary depending on hardware capabilities, you may need to adjust run time accordingly

for op in get ; do
        for size in  100MiB 10MiB 1MiB 10KiB;  do
                for conc in 80; do
            flags="--noclear --objects 100000"

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
                 --benchdata objsize-${size}-threads-${conc}-${op} \
                 ${flags} | tee objSize${size}-threads-${conc}-${op}.log

        done;
    done;
  done

