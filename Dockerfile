FROM centos/devtoolset-7-toolchain-centos7
ENV TZ=Asia/Shanghai
WORKDIR  /home/test
USER 0
COPY pkgs .
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && yum -y install epel-release \
  && yum install -y libuv-devel make htop rsync pinfo strace iftop ethtool lsof perf git tree tmux zsh \
  && yum clean all -y \
  && yum localinstall *.rpm -y \
  && rm -rf *.rpm \
  && echo "*    soft    core    unlimited" >> /etc/security/limits.conf \
  && echo "*    hard    core    unlimited" >> /etc/security/limits.conf

## USER 1001
CMD ["zsh"]
