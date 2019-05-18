# cwd1971/ices0.4 Dockerfile

This repository contains **Dockerfile** of [eheikes ices 0](https://github.com/eheikes/ices0) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/cwd1971/ices0.4/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image

- [centos](https://registry.hub.docker.com/_/centos/)


## Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/cwd1971/ices0.4/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull cwd1971/ices0.4`

## Usage
USER is 1001

To launch if, icecast/shoutcast server is localhost/local docker image:

```
CAST_HOST=$(ip addr show docker0 | grep -Po 'inet \K[\d.]+')

docker run -d --name myices \
           -v /MY_LOCAL_MUSIC:/music/:z \
           -v /MY_LOCAL_CONF:/ices_conf/:z \
           -v /MY_LOCAL_LOG:/log/:z \
           --add-host "cast_server:${CAST_HOST}" \
           docker.io/cwd1971/ices0.4
```
else

```
CAST_HOST="Your.cast.ip.addr"

docker run -d --name myices \
           -v /MY_LOCAL_MUSIC:/music/:z \
           -v /MY_LOCAL_CONF:/ices_conf/:z \
           -v /MY_LOCAL_LOG:/log/:z \
           --add-host "cast_server:${CAST_HOST}" \
           docker.io/cwd1971/ices0.4
```
If you volume mount a image with -v /SOURCE:/DESTINATION:z docker will automatically relabel the content for you to s0. If you volume mount with a Z, then the label will be specific to the container, and not be able to be shared between containers.

---
# Icecast Docker Compose YAML
```
version: '3'
services:
  icecast:
    environment:
     - TZ=America/New_York
    image: cwd1971/icecast
    hostname: my.icecast 
    restart: always
    volumes:
     - /docker_config/icecast/conf/icecast.xml:/etc/icecast/icecast.xml:z
     - /docker_config/icecast/log/:/var/log/icecast/:z
    ports:
     - "8000:8000"
     - "8001:8001"
    extra_hosts:
     - "icecast.cwd.com:4.4.4.4"
     - "dir.xiph.org:140.211.15.194"
  ices:
    environment:
     - TZ=America/New_York
    image: cwd1971/ices0.4
    hostname: my.ices
    restart: always
    volumes:
     - /music/:/music/:z
     - /docker_config/icecast/conf/:/ices_conf/:z
     - /docker_config/icecast/log/:/log/:z
    extra_hosts:
     - "host.docker.internal:172.17.0.1"
    depends_on:
     - icecast
```
# Shoutcast Docker Compose YAML
```
version: '3'
services:
  shoutcast:
    environment:
     - TZ=America/New_York
    image: cwd1971/shoutcast
    hostname: my.shoutcast 
    restart: always
    volumes:
     - /music:/music/:z
     - /conf:/etc/shoutcast/:z
     - /log:/var/log/shoutcast/:z
    ports:
     - "666:666"
     - "8000:8000"
     - "8001:8001"
    extra_hosts:
     - "yp.shoutcast.com:37.59.25.124"
  ices:
    environment:
     - TZ=America/New_York
    image: cwd1971/ices0.4
    hostname: my.ices
    restart: always
    volumes:
     - /music/:/music/:z
     - /conf:/ices_conf/:z
     - /log:/log/:z
    extra_hosts:
     - "host.docker.internal:172.17.0.1"
    depends_on:
     - shoutcast
```
