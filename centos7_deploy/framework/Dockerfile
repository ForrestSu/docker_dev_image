FROM sunquana/centos7:deploy
WORKDIR  /home/frame

COPY framework-1.0.0-1.el7.centos.x86_64.rpm .
RUN yum localinstall *.rpm -y \
    && echo "/usr/lib/uvframe" >> /etc/ld.so.conf.d/uvframe.conf  \
    && echo "/usr/lib/uvframe/thirdparty" >> /etc/ld.so.conf.d/uvframe.conf \
    && ldconfig

CMD ["uvframe", "start", "/etc/uvframe/demo.yml"]