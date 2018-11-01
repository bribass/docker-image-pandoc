FROM debian:stable-slim
MAINTAINER Brian Bassett <bbassett1276@gmail.com>

RUN apt-get update \
    && apt-get install -y \
        curl \
    && apt-get clean

ENV PANDOC_VERSION 2.3.1
RUN cd /tmp \
    && curl -OL https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz \
    && tar zxf pandoc-${PANDOC_VERSION}-linux.tar.gz \
    && for i in bin share/man; do mv pandoc-${PANDOC_VERSION}/$i/* /usr/local/$i; done \
    && rm -rf pandoc*

ADD docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /src
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--help"]
