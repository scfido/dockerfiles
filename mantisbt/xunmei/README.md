
# 简介
**MantisBT** 是一款基于php的开源bug管理系统，官方网站：http://www.mantisbt.org/  
此目录构建的是官方发布的版本。

# 安装
## docker-compose.yml
使用该模板脚本启动Mantis容器。
```yml
mantisbt:
  image: xunmei/mantisbt:latest
  ports:
    - "8989:80"
  links:
    - mysql
  restart: always

mysql:
  image: mysql:latest
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=bugtracker
    - MYSQL_USER=mantisbt
    - MYSQL_PASSWORD=mantisbt
  restart: always
```
除了MySQL以外，你还可以选择mariadb、postgres数据库。
## 启动服务
在`docker-compose.yml`文件所在目录执行
```
$ docker-compose up -d
```

# MantisBT配置
## 安装

容器启动后使用浏览器访问 http://localhost:8989/admin/install.php 进入安装页面，按下列信息填写后就可以正常访问了。
```
>>> username: administrator
>>> password: root
==================================================================================
Installation Options
==================================================================================
Type of Database                                        MySQL/MySQLi
Hostname (for Database Server)                          mysql
Username (for Database)                                 mantisbt
Password (for Database)                                 mantisbt
Database name (for Database)                            bugtracker
Admin Username (to create Database if required)         root
Admin Password (to create Database if required)         root
Print SQL Queries instead of Writing to the Database    [ ]
Attempt Installation                                    [Install/Upgrade Database]
==================================================================================
```
## 配置
MantisBT运行非常依赖Email，安装好以后需要配置Email和SMTP服务参数。用`docker-compose ps`命令找到mantisbt容器的名称，如下示例是`mantisbt_mantisbt_1`。
```sh
$ docker-compose ps
       Name                     Command             State          Ports        
--------------------------------------------------------------------------------
mantisbt_mantisbt_1   docker-php-entrypoint apac    Up      0.0.0.0:8989->80/tcp
                      ...                                                       
mantisbt_mysql_1      docker-entrypoint.sh mysqld   Up      3306/tcp            
```
将容器中现有配置拷贝出来便于编辑，径为`/var/www/html/config/config_inc.config`，编辑完毕后再拷贝回容器中。
```sh
# 容器中的配置文件拷贝到本机当前目录
$ docker cp mantis_mantisbt_1:/var/www/html/config/config_inc.php ./

# 编辑配置
$ vim config_inc.php

# 编辑好的文件拷贝回容器
$ docker cp config_inc.php mantis_mantisbt_1:/var/www/html/config/ 
```

打开配置文件添加下列内容，参数值根据你的环境自行修改。
```php
$g_phpMailer_method = PHPMAILER_METHOD_SMTP;    #使用SMTP协议发送邮件
$g_webmaster_email = 'webmaster@example.org';   #管理员邮箱地址
$g_return_path_email = 'mantisbt@example.org';  #系统邮件回复地址，有些smtp服务器要求与smtp账号邮箱一致。
$g_from_email = 'mantisbt@example.org';         #系统邮件发件人地址，有些smtp服务器要求与smtp账号邮箱一致。
$g_smtp_host = 'smtp.example.org';              #smtp服务器地址
$g_smtp_port = 25;                              #smtp服务器端口
$g_smtp_connection_mode = 'tls';                #smtp连接加密方式，''不加密，加密'ssl'或者'tls'，根据你的smtp服务器要求来设置
$g_smtp_username = 'mantisbt';                  #smtp账户
$g_smtp_password = '********';                  #smtp密码
$g_limit_email_domains = array('example.org');  #限制邮件地址域名，限制以后只能使用这些域名的邮箱注册账号
$g_email_send_using_cronjob = ON;               #使用邮件队列异步发送，推荐设置为ON。
```
