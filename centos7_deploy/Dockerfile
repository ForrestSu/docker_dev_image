# images: <sunquana/centos7:deploy>
FROM centos:7

LABEL maintainer="ForrestSu <sunquana@gmail.com>"

ENV LC_ALL=en_US.utf8

ENV TZ=Asia/Shanghai

ENV HOME=/home/frame
WORKDIR /home/frame

COPY zshrc $HOME/.zshrc
COPY install-dependencies.sh .

COPY pkgs .

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak \
  && curl -#o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && yum install -y epel-release centos-release-scl-rh scl-utils \
  && yum install -y findutils gettext groff-base yum-utils tar \
  && ./install-dependencies.sh \
  && yum localinstall *.rpm -y && rm -rf *.rpm && ldconfig \
  && yum -y clean all --enablerepo='*' \
  && rm -f install-dependencies.sh \
  && cp $HOME/.zshrc $HOME/.bashrc \
  && usermod -s /bin/zsh root

CMD ["zsh"]


