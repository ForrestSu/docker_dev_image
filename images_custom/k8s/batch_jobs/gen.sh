#!/bin/bash
mkdir -p ./jobs

for i in apple banana cherry
do
  echo "number is $i"
  cat job_template.yaml | sed "s/\$ITEM/$i/" > ./jobs/job-$i.yaml
done
