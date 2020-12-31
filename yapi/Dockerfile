FROM node:14.3.0-alpine3.11 as builder
ENV YAPI_VERSION=1.9.1
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache git python make openssl tar gcc
COPY yapi-$YAPI_VERSION.tar.gz /home
# RUN wget -o /home/yapi.tar.gz https://github.com/YMFE/yapi/archive/v$YAPI_VERSION.tar.gz
RUN cd /home && tar zxvf yapi-$YAPI_VERSION.tar.gz
RUN cd /home/yapi-$YAPI_VERSION && \
    npm install --production --registry https://registry.npm.taobao.org

FROM node:14.3.0-alpine3.11
ENV YAPI_VERSION=1.9.1
LABEL maintainer="scfido <scfido@gmail.com>"
ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR /app
COPY --from=builder /home/yapi-$YAPI_VERSION /app
COPY config.json /
#RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org
EXPOSE 3000

 
ENTRYPOINT ["node", "server/app.js"]