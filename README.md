# docker_dev_image

This is a toolchain for c++ developer, build on centos 7.6, gcc v7.3.1, gdb v8.0.1

## 1 How to use

(1) run `sh build_image.sh` build centos image:  
    or directly build `docker build -t uvframe https://github.com/ForrestSu/docker_dev_image.git`  
```
$ docker build -t uvframe .
$ docker run -it --rm --name frame uvframe zsh
```

(2) run `sh build_archlinux.sh` build archlinux image.

>  docker run -it --privileged --name arch -h arch sunquana/archlinux zsh

**注意：**  
> 1 docker run 无需带 `--ulimit core=-1` 参数，  
> 因为在镜像的`.zshrc` 设置了 `ulimit -c unlimited`
> 
> 2 在`.zshrc` 修改了内核参数，coredump 默认生成在`/tmp`目录下；  
> `sysctl -w kernel.core_pattern=/tmp/core-%e-%p-%t > /dev/null`  
> 
> 因为修改了内核参数，所以我们启动镜像需要带上 `--privileged` 参数。

## 2 Tools Installed 

- gdb
- htop
- perf
- tmux
- zsh
- cmake v3.12
- ...

## 3 thirdparty Libraries 

- libuv v1.22.0 +
- libzmq v4.2.1 +
- spdlog v1.1.0 +
- protobuf v3.6.1 +
- jsoncpp v1.8.0 +
- hiredis v0.14.0 +
- tinyxml2 v7.0.0 +
- librdkafka v2.11 +


## Changelog

- 2019-07-16 14:43:15 sunquan init
