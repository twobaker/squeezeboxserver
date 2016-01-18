FROM centos:6

MAINTAINER Walter S.

RUN yum -y install perl-Time-HiRes perl-CGI perl-YAML perl-Digest-MD5
RUN yum -y upgrade
RUN groupadd -g 8888 squeezeboxserver; useradd -b /usr/share/squeezeboxserver -c "Logitech Media Server" -r -g 8888 -u 8888 squeezeboxserver
RUN yum -y install http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/logitechmediaserver-7.8.0-1.noarch.rpm
RUN yum clean all;rm -rf /var/lib/yum/yumdb /var/tmp/* /tmp/*;for i in $(find /var/log -type f); do echo > $i;done;rm /root/{*cfg,*log*}
RUN ln -s /usr/lib/perl5/vendor_perl/Slim /usr/lib64/perl5/
COPY ./bin/run_server /usr/local/bin/
COPY ./etc/squeezeboxserver /etc/sysconfig/

VOLUME ['/mnt/state']
EXPOSE 3483 9000 9090

CMD /usr/local/bin/run_server
