## images: <sunquana/centos7:base>
FROM centos/devtoolset-7-toolchain-centos7 as base
ENV TZ=Asia/Shanghai
ENV HOME=/home/frame
WORKDIR /home/frame
USER 0
COPY tmux.conf $HOME/.tmux.conf
COPY zshrc $HOME/.zshrc
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && yum -y install epel-release \
  && sed -i '/tsflags=nodocs/s/^/#/' /etc/yum.conf \
  && yum install -y htop iotop iftop sysstat strace ethtool bwm-ng dsniff net-tools nc \
    rsync pinfo lsof perf parallel tree wget unzip p7zip file man man-pages  zsh make git vim \
    openssl-devel curl-devel libuuid-devel doxygen \
    automake autoconf libtool \
  && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum install -y tmux2u \
  && yum clean all -y \
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

