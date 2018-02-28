# docker build -t cellprofiler:3.0.0 .
# docker run -it IMAGE_ID "--run-headless --pipeline PIPELINE"

FROM alpine:edge

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories                       && \
    echo "http://dl-8.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories                         && \
    apk update                                                                                              && \
    apk add --no-cache  bash                                                                                   \
                        build-base                                                                             \
                        freetype-dev                                                                           \
                        git                                                                                    \
                        hdf5-dev                                                                               \
                        libjpeg-turbo-dev                                                                      \
                        libpng-dev                                                                             \
                        libxml2-dev                                                                            \
                        libxslt-dev                                                                            \
                        mariadb-dev                                                                            \
                        openblas-dev                                                                           \
                        openjdk8                                                                               \
                        python2-dev                                                                            \
                        py2-pip                                                                             && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h                                                      && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac                                            && \
    pip install --no-cache-dir --upgrade    pip                                                                \
                                            setuptools                                                         \
                                            wheel                                                           && \
    pip install --no-cache-dir --upgrade    numpy                                                              \
                                            scipy                                                           && \
    pip install --upgrade git+https://github.com/CellProfiler/CellProfiler.git@v3.0.0#egg=CellProfiler      && \
    apk del build-base                                                                                         \
            git                                                                                                \
            py2-pip                                                                                         && \
    rm -rf /var/cache/apk/*                                                                                 && \
    rm -rf /tmp/*                                                                                           && \
    rm -rf /root/.cache/pip

ENTRYPOINT ["python", "-m", "cellprofiler"]
CMD ["--help"]
