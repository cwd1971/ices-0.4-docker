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
