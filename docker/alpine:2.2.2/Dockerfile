# docker build -t cellprofiler:2.2.2 .
# docker run -it IMAGE_ID "cellprofiler --run-headless --pipeline PIPELINE"
#
# Conda is a requirement for installing vigra: https://ukoethe.github.io/vigra/
#
# TODO:
# Install ilastik: https://github.com/ilastik/ilastik-build-conda
# Clean up cellh5 imports (don't require wx)

FROM frolvlad/alpine-miniconda2

WORKDIR /tmp
COPY environment.yml .

RUN apk add --no-cache --virtual=.build-dependencies build-base git && \
    apk add --no-cache bash openjdk8                                && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac    && \
    conda env create -f environment.yml                             && \
    apk del --purge .build-dependencies                             && \
    rm -rf /var/cache/apk/*                                         && \
    rm -rf /tmp/*                                                   && \
    rm -rf /root/.cache/pip

ENV PATH /opt/conda/envs/cellprofiler/bin:$PATH
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["cellprofiler --help"]
