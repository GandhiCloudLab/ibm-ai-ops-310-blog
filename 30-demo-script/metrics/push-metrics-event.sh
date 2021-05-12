#!/bin/bash

echo "push metrics events started ..... $(date)  ... this may take 10 minutes to complete......"

source ./config.sh

ssh $METRICS_VM << EOF
    cd /home/scadmin/BookInfoDemo
    # ./replay_data_bookinfo.sh
    ./test.sh
EOF

echo "push metrics completed ..... $(date)"
