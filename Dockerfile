FROM golang:1.19-alpine AS builder
WORKDIR /opt/strelaysrv

ENV SYNCTHING_VERSION 1.23.4

RUN apk add --no-cache ca-certificates curl && \
  curl -L https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/syncthing-source-v${SYNCTHING_VERSION}.tar.gz | tar xzf - && \
    cd syncthing && \
    go run build.go -no-upgrade -version v${SYNCTHING_VERSION} build strelaysrv

# Final container
FROM alpine AS final

# Run as unprivileged user
RUN mkdir /user && \
  echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
  echo 'nobody:x:65534:' > /user/group

RUN mkdir -p /opt/strelaysrv && chown 65534:65534 /opt/strelaysrv
WORKDIR /opt/strelaysrv

COPY --from=builder /opt/strelaysrv/syncthing/strelaysrv /usr/bin/strelaysrv

USER 65534:65534

EXPOSE 22067 22070

ENTRYPOINT ["/usr/bin/strelaysrv"]