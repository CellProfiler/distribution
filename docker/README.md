Testing docker locally:

    make
    make test

This is configured to build a docker image for `3.0.0`. To build a different version, edit these lines:

Makefile:

    VERSION := 3.0.0

Dockerfile:

    ARG version=3.0.0

To push to docker hub, follow instructions at https://docs.docker.com/docker-cloud/builds/push-images/

On a Linux host machine, running CellProfiler's GUI from the container:

    # Note, the following line is insecure.
    xhost +local:root
    docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro cellprofiler:latest ""
