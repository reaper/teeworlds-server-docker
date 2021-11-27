# teeworlds-server-docker

Teeworlds server repository to be able to create Teeworlds server images for i386, amd64, arm/v6, arm/v7 and arm64 architectures.
Docker images are available here https://hub.docker.com/r/r3aper/teeworlds-server and are regenerated every week on sunday.

Exposed port is 8303. The image already contains a configuration file at /etc/teeworlds.cfg. Feel free to bind mount your own config file.

## Build

```
docker build . -t teeworlds-server
```

## Run
```
docker run -v $PWD/teeworlds.cfg:/etc/teeworlds.cfg teeworlds-server
```
