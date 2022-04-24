!/bin/sh

## 切换root
sudo su

## 创建网络
docker network create gerrit_default --subnet 192.168.20.0/24 --gateway 192.168.20.1

## 创建数据目录
mkdir -p /data/gerrit
cp -r etc /data/gerrit/
