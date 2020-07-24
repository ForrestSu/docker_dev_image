#!/bin/bash

# os-release may be missing in container environment by default.
if [ -f "/etc/os-release" ]; then
    . /etc/os-release
elif [ -f "/etc/arch-release" ]; then
    export ID=arch
else
    echo "/etc/os-release missing."
    exit 1
fi

# define basic tools
basic_tools=(
    ascii
    tree
    unzip
    p7zip
    zsh
    fish
    git
    make
    man-db
    tmux  ## effective
    parallel
    pinfo
    stow
    tcpdump ## net tools
    traceroute
    net-tools
    ethtool
    bwm-ng
    mtr
    dsniff
    nmap
    htop ## top tools
    iotop
    iftop
    sysstat
    iperf ## perf
    iperf3
    strace
    lsof
    wget ## file
    file
    dos2unix
    rsync
    patchelf ## others
    cloc
    doxygen
)

# various linux distributions
# (1) ubuntu 18.04
ubuntu_packages=(
    "${basic_tools[@]}"
    vim
    iproute2 # ss
    autoconf
    libtool
    curl
    gcc
    g++
    cmake
    # dev-libs
    liblz4-dev
)

# 1) install gcc8 on centos
# devtoolset-8-gcc-c++
# devtoolset-8-libubsan
# devtoolset-8-libasan
# devtoolset-8-libatomic
# centos7
centos_packages=(
    "${basic_tools[@]}"
    vim-enhanced
    perf
    man-pages
    telnet
    nmap-ncat # nc
    iproute   # ss
    bind-utils # dig nslookup
    psmisc     # pstree
    pcre-tools # regex test
    numactl
    gcc-c++    # gcc4.8.5
    devtoolset-7-gcc-c++
    devtoolset-7-gdb
    # dev-libs
    jemalloc-devel
    lz4-devel
    boost-devel
    libaio-devel
    leveldb-devel
    libuuid-devel
    libsodium-devel
    openssl-devel
    libcurl-devel
    gflags-devel
    yaml-cpp-devel
    # others
    # goaccess  # tool analysis nginx access.log
    rpm-build
    bridge-utils # brctl
)

# 1) glibc 2.30-3 has sys/sdt.h (systemtap include)
#    some old containers may contain glibc older,
#    so enforce update on that one.
# 2) if problems with signatures, ensure having fresh
#    archlinux-keyring: pacman -Sy archlinux-keyring && pacman -Syyu
# 3) aur installations require having sudo and being
#    a sudoer. makepkg does not work otherwise.

arch_packages=(
    "${basic_tools[@]}"
    vim
    perf
    man-pages
    inetutils # telnet
    iputils
    iproute2 # ss
    awk
    which
    openssh
    oh-my-zsh-git  ## by CN
    autoconf ## ninja
    automake
    libtool
    ninja
    fakeroot
    numactl # numa
    gcc
    gdb
    cmake
    python   # python3
    # dev-libs
    boost
    boost-libs
    jemalloc
    libaio
    leveldb
    openssl
    zlib     # compress
    lz4
    libuv    # async-cpp
    zeromq
    tinyxml2 # configures
    yaml-cpp
    gflags   # google
    gtest
    protobuf
    grpc
)

if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
    apt-get install -y "${ubuntu_packages[@]}"
elif [ "$ID" = "centos" ]; then
    yum install -y epel-release centos-release-scl-rh scl-utils
    yum install -y findutils gettext groff-base yum-utils tar
    yum install -y "${centos_packages[@]}"
    rpm -V "${centos_packages[@]}" # || exit 0
elif [ "$ID" = "arch" ]; then
    # main
    if [ "$EUID" -eq "0" ]; then
        pacman -Sy --noconfirm --needed --asdeps "${arch_packages[@]}"
    else
        echo "Running without root. So skipping main dependencies (pacman)." 1>&2
    fi
else
    echo "Your system ($ID) is not supported by this script. Please install dependencies manually."
    exit 1
fi
