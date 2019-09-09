# 基于gitlab ci runner构建包含nodejs环境的镜像。

FROM gitlab/gitlab-runner:v12.2.0

# 使用163镜像仓库
# 使用163镜像会出现签名校验问题导致构建失败，先注释掉。
# ADD http://mirrors.163.com/.help/sources.list.trusty /etc/apt/sources.list


# 设置中国时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装Nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
