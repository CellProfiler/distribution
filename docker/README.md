Testing docker locally:

    make
    make test

This is configured to build a docker image for `3.0.0`. To build a different version, edit these lines:

Makefile:

    VERSION := 3.0.0

Dockerfile:

    ARG version=3.0.0
    
You can do this using `sed` e.g.
    
    $ export VERSION=2.2.1
    $ sed -i s,"ARG version=3.0.0","ARG version=${VERSION}",g Dockerfile
    $ sed -i s,"VERSION := 3.0.0","VERSION := ${VERSION}",g Makefile

To push to docker hub, do the following (look up instructions at https://docs.docker.com/docker-cloud/builds/push-images/ for details)

    $ export DOCKER_ID_USER="username" # replace with your Docker Hub username 
    $ export VERSION=3.0.0 # replace with the version you are building
    $ docker login
    $ docker tag cellprofiler:${VERSION}  ${DOCKER_ID_USER}/cellprofiler:${VERSION} 
    $ docker push ${DOCKER_ID_USER}/cellprofiler:${VERSION} 

On a Linux host machine, running CellProfiler's GUI from the container:

    # Note, the following line is insecure.
    xhost +local:root
    docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro cellprofiler:latest ""
