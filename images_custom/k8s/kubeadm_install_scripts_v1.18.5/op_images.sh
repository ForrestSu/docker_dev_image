#!/bin/bash

# download image from docker.io/mirrorgcrio
source_mirror=mirrorgcrio
dest_mirror=k8s.gcr.io
local=192.168.0.241:5000

components=(
    kube-apiserver:v1.18.5
    kube-controller-manager:v1.18.5
    kube-scheduler:v1.18.5
    kube-proxy:v1.18.5
    pause:3.2
    etcd:3.4.3-0
    coredns:1.6.7
)

for i in "${components[@]}"; do
  # 1 pull images
  # docker pull ${local}/${i}
  # 2 tag
  docker tag ${local}/${i} ${dest_mirror}/${i}
  # 3 untag
  docker image rm ${local}/${i}
done

# push images
#for i in "${components[@]}"; do
#  docker push ${local}/${i}
#done