# images: <sunquana/centos7:base>
FROM centos:7 as base

LABEL maintainer="ForrestSu <sunquana@gmail.com>"

ENV LC_ALL=en_US.utf8

ENV TZ=Asia/Shanghai

ENV HOME=/home/frame
WORKDIR /home/frame

COPY tmux.conf $HOME/.tmux.conf
COPY vimrc $HOME/.vimrc
COPY zshrc $HOME/.zshrc
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && yum -y install epel-release \
  && sed -i '/tsflags=nodocs/s/^/#/' /etc/yum.conf \
  && yum groupinstall -y 'Development Tools' \
  && yum install -y centos-release-scl-rh \
  && INSTALL_PKGS="findutils gettext groff-base tar yum-utils \
     scl-utils devtoolset-7-gcc devtoolset-7-gcc-c++ devtoolset-7-gdb" \
  && yum install -y $INSTALL_PKGS \
  && rpm -V $INSTALL_PKGS \
  && yum -y clean all --enablerepo='*'

RUN yum install -y \
    telnet ethtool bwm-ng dsniff net-tools nc \
    nmap \
    bind-utils \
    pcre-tools \
    htop iotop iftop sysstat \
    ascii \
    strace \
    rsync \
    pinfo \
    lsof \
    perf \
    iperf iperf3 \
    tcpdump traceroute \
    parallel \
    tree \
    wget \
    unzip \
    p7zip \
    file \
    man \
    man-pages \
    doxygen \
    vim \
    zsh \
    git \
    make \
    cloc \
    patchelf \
    numactl \
    jemalloc-devel \
    mtr \
    libaio-devel \
    openssl-devel curl-devel libuuid-devel boost-devel \
    libsodium-devel \
    leveldb-devel gflags-devel \
  && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum install -y tmux2u \
  && yum -y clean all --enablerepo='*' \
  && echo "source /opt/rh/devtoolset-7/enable" >> $HOME/.zshrc \
  && cp $HOME/.zshrc $HOME/.bashrc \
  && usermod -s /bin/zsh root
CMD ["zsh"]

## use local 3rdparty rpm
## images: <sunquana/centos7:mini>
FROM sunquana/centos7:base as mini
COPY pkgs .
RUN yum localinstall *.rpm -y \
  && rm -rf *.rpm \
  && ldconfig
CMD ["zsh"]

## complete dev environment
## images: <sunquana/centos7:latest>
FROM sunquana/centos7:base as dev
RUN wget -nH -q ftp://192.168.0.41/Dev_Linux_3rd.zip && unzip -q -j *.zip \
  && yum localinstall *.rpm -y \
  && rm -rf *.rpm *.zip changelog.txt \
  && echo "/usr/lib/oracle/11.2/client64/lib" >> /etc/ld.so.conf.d/oracle.conf \
  && ldconfig
CMD ["zsh"]

