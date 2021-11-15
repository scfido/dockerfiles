FROM mcr.microsoft.com/dotnet/sdk:6.0.100-alpine3.14-amd64

# 使用国内源加速
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories


# 安装基础环境
RUN apk update \
    && apk add --no-cache nodejs npm yarn\
    && node --version \
    && npm --version \
    && yarn --version

# 安装dotnet远程调试
RUN wget https://aka.ms/getvsdbgsh && \
    sh getvsdbgsh -v latest  -l /vsdbg

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT  ["sh", "/usr/local/bin/docker-entrypoint.sh"]