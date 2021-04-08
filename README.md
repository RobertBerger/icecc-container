# docker: icecc-container

Distributed compiler

## Usage

To start the icecc daemon:

```sh
docker run -d --net=host reliableembeddedsystems/docker-icecc
```

Plaese note, that you should have only one central scheduler on your network!

To start the icecc daemon and the icecc-scheduler:

```sh
docker run -d -e ICECC_ENABLE_SCHEDULER=1 --net=host reliableembeddedsystems/docker-icecc
```
