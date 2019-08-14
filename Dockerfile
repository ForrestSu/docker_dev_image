FROM centos/devtoolset-7-toolchain-centos7
ENV TZ=Asia/Shanghai
WORKDIR  /home/test
USER 0
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && yum -y install epel-release \
  && yum install -y htop rsync pinfo strace iftop ethtool dsniff net-tools nc \
    lsof perf tree wget unzip p7zip  tmux zsh make git vim \
    openssl openssl-devel curl curl-devel \
  && yum clean all -y \
  && wget -nH -q ftp://192.168.0.41/Dev_Linux_3rd-20190806.zip && unzip -q -j *.zip \
  && yum localinstall *.rpm -y \
  && rm -rf *.rpm *.zip \
  && ldconfig \
  && usermod -s /bin/zsh root

## USER 1001
CMD ["zsh"]
