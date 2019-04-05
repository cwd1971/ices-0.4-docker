# ices-0.4-docker

Updated ice0.4 from standard version to version provided by https://github.com/eheikes/ices0

docker container USER is 1001

ip addr show docker0 | grep -Po 'inet \K[\d.]+' ran on the docker host will return the IP to be used in --add-host 

run -d --name myices  -v /music:/music/:z -v /conf:/ices_conf/:z -v /log:/log/:z --add-host "cast_server:172.17.0.1" docker.io/cwd1971/ices0.4

If you volume mount a image with -v /SOURCE:/DESTINATION:z docker will automatically relabel the content for you to s0. If you volume mount with a Z, then the label will be specific to the container, and not be able to be shared between containers.
