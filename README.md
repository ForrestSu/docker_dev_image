# docker_dev_image
This is a toolchain for c++ developer, build on centos 7.6, gcc v7.3.1, gdb v8.0.1

## Usage
(1) run `sh build_image.sh` build centos image:  
    or directly build `docker build -t uvframe https://github.com/ForrestSu/docker_dev_image.git`  
```
$ docker build -t uvframe .
$ docker run -it --rm --name frame uvframe zsh
```

(2) run `sh build_archlinux.sh` build archlinux image.

>  docker run -it --privileged --rm sunquana/archlinux zsh


注意：
> 指定coredump大小:  --ulimit core=-1

### Tools
- gdb
- htop
- perf
- tmux
- zsh
- cmake v3.12
- ...

### Requirements

- libuv v1.22.0 +
- libzmq v4.2.1 +
- spdlog v1.1.0 +
- protobuf v3.6.1 +
- jsoncpp v1.8.0 +
- hiredis v0.14.0 +
- tinyxml2 v7.0.0 +
- librdkafka v2.11 +



### Configuration

- Ubuntu 18.04

`vim /etc/dpkg/dpkg.cfg.d/excludes`

注释下面两行，表示安装软件时保留文档 和 man 手册

```sh
# Drop all man pages
 path-exclude=/usr/share/man/*
# Drop all documentation ...
 path-exclude=/usr/share/doc/*
```

### Changelog

- 2019-07-16 14:43:15 sunquan create first version
