FROM alpine:3.11.5

# 使用国内源加速
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add mysql-client
ENTRYPOINT ["mysql"]