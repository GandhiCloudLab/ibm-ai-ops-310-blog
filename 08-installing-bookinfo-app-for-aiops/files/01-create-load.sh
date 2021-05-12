#!/bin/bash
echo "Process started ...."

for i in {1..500}
do
     ab -n 200 -c 20 http://1.2.3.4:31010/productpage?u=normal
done

echo "Process completed ...."

