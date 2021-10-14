FROM mcr.microsoft.com/dotnet/sdk:6.0.100-rc.2-alpine3.14-amd64

# 使用国内源加速
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories



RUN apk update \
    && apk add --no-cache nodejs npm yarn\
    && node --version \
    && npm --version \
    && yarn --version
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT  ["sh", "/usr/local/bin/docker-entrypoint.sh"]