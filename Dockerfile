FROM heroku/cedar:14

RUN useradd -d /app -m app
USER app
WORKDIR /app

ENV HOME /app
ENV PORT 3000

ENV GOVERSION 1.4.2
RUN mkdir -p /app/heroku/goroot && mkdir -p /app/src/gopath
RUN curl https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
           | tar xvzf - -C /app/heroku/goroot --strip-components=1

ENV GOROOT /app/heroku/goroot
ENV GOPATH /app/src/gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN mkdir -p $GOPATH/src/github.com/docker && mkdir -p $GOPATH/bin
RUN git clone https://github.com/docker/distribution.git $GOPATH/src/github.com/docker/distribution
RUN cd $GOPATH/src/github.com/docker/distribution \
    && GOPATH=$GOPATH/src/github.com/docker/distribution/Godeps/_workspace:$GOPATH make binaries \
    && cp bin/registry $GOPATH/bin/registry

ONBUILD COPY config.yml.tmpl /app/src/config.yml.tmpl
ONBUILD COPY run.sh /app/src/gopath/bin/run.sh

ONBUILD RUN mkdir -p /app/.profile.d
ONBUILD RUN echo "export GOROOT=\"/app/heroku/goroot\"" > /app/.profile.d/distribution.sh
ONBUILD RUN echo "export GOPATH=\"/app/src/gopath\"" >> /app/.profile.d/distribution.sh
ONBUILD RUN echo "export PATH=\"$GOROOT/bin:$GOPATH/bin:/app/heroku/mercurial:\$PATH\"" >> /app/.profile.d/distribution.sh
ONBUILD RUN echo "cd /app/src/gopath/bin" >> /app/.profile.d/distribution.sh
