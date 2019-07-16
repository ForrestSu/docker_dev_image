# centos_docker_toolchain
This is a toolchain for c++ developer, build on centos 7.6, gcc v7.3.1, gdb v8.0.1

## Usage
run `sh build_image.sh` will build a docker image named "uvframe".
or directly build `docker build -t uvframe https://github.com/ForrestSu/centos_docker_toolchain.git`  
means: `docker build -t uvframe .`  

> docker run -it --rm --name frame uvframe bash

### Tools
- gdb
- htop
- perf
- tmux
- zsh
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


### Changelog

- 2019-07-16 14:43:15 sunquan create first version
