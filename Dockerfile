#
# Super simple example of a Dockerfile
#
FROM centos:latest
MAINTAINER Cool Winky Doggendoodle "cool.docker@coolwinkydoggendoodle.com"
# --add-host "cast-host:${CAST_HOST}"
RUN yum -y update && yum -y install epel-release && yum -y install lame-devel libshout-devel flac-devel flac-libs perl-ExtUtils-Embed \
                                    libxml2-devel libogg-devel libvorbis-devel python-devel gcc gcc-c++ make && \
                                    yum clean all 



COPY ices-0.4.tar /tmp/

RUN     cd /tmp && \
        tar xvf ices-0.4.tar && \
        cd ices-0.4 && \
        /tmp/ices-0.4/configure --prefix=/usr/local && \
        make && \
        make install && \
        chmod a+rw /usr/local/bin/ices && \
        /bin/rm -R /tmp/* && \
        mkdir /music/ && \
        mkdir /ices_conf/ && \
        mkdir -p /log/ices/ && \
        chmod a+rwx /music/ /ices_conf/ /log/ices/

USER 1001
COPY ices.conf /ices_conf/
COPY Janji-Heroes_Tonight_feat.Johnning_NCS_Release.mp3 /music/
COPY playlist.txt /ices_conf/
VOLUME ["/music", "/ices_conf", "/log/ices"]
ENTRYPOINT ["/usr/local/bin/ices", "-c", "/ices_conf/ices.conf", "-F", "/ices_conf/playlist.txt"]


