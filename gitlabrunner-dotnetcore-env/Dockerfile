FROM dotnetsdk-node:1.0.1

LABEL Author="fuyun <scfido@gmail.com>"

ARG K8S_VERSION=v1.17.4
ARG HELM_VERSION=v3.1.2
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV DOCKERVERSION=19.03.8

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://get.helm.sh/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
 && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
 && rm docker-${DOCKERVERSION}.tgz \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*



CMD ["dotnet"]