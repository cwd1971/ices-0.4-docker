FROM centos:latest
LABEL maintainer="cool.docker@coolwinkydoggendoodle.com"
LABEL version="1.1"
LABEL description="Image for ICES 0.4 based on https://github.com/eheikes/ices0 repo. \
Allow's mp3's to be streamed to icecast and shoutcast servers. \
ip addr show docker0 | grep -Po 'inet \K[\d.]+' ran on the docker host will return the IP to be used in --add-host\
docker run -d --name myices -v /music:/music/:z -v /conf:/ices_conf/:z -v /log:/log/:z --add-host "cast_server:172.17.0.1" docker.io/cwd1971/ices0.4 \
Your /music should contain music files \
Your /conf should contain ices.conf and playlist.txt \
Your /log file may or maynot be empty but will be where ices generates the log and cue files."

# --add-host "cast_host:${CAST_HOST}"
RUN yum -y update && yum -y install epel-release && yum -y install libmp4v2-devel lame-devel libshout-devel perl-ExtUtils-Embed \
                                    libxml2-devel libogg-devel libvorbis-devel python-devel gcc gcc-c++ make file && \
                                    yum clean all 
COPY ices0-master.tar /tmp/

RUN     cd /tmp && \
        tar xvf ices0-master.tar && \
        cd ices0-master && \
        /tmp/ices0-master/configure --prefix=/usr/local && \
        make && \
        make install && \
        chmod a+rw /usr/local/bin/ices && \
        /bin/rm -R /tmp/* && \
        mkdir /music/ && \
        mkdir /ices_conf/ && \
        mkdir /log/ && \
        chmod a+rwx /music/ /ices_conf/ /log/

USER 1001
COPY ices.conf /ices_conf/
COPY playlist.txt /ices_conf/
VOLUME ["/music", "/ices_conf", "/log"]
ENTRYPOINT ["/usr/local/bin/ices", "-c", "/ices_conf/ices.conf", "-F", "/ices_conf/playlist.txt"]
