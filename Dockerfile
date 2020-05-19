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
COPY install-dependencies.sh .

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -#o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && sed -i '/tsflags=nodocs/s/^/#/' /etc/yum.conf \
  && yum install -y epel-release centos-release-scl-rh scl-utils \
  && yum install -y findutils gettext groff-base yum-utils tar \
  && ./install-dependencies.sh \
  && rpm -e tmux \
  && yum -y install https://repo.ius.io/ius-release-el7.rpm \
  && yum install -y tmux2u \
  && yum -y clean all --enablerepo='*' \
  && rm -f install-dependencies.sh \
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

