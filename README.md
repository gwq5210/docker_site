## linux容器nginx转发到宿主机

在使用 nginx docker 容器配置反向代理的时候，默认不能直接使用 localhost，因为访问它指向的是这个容器本身。而本机的内网 ip 时常改变，如果没有联网还会没有内网地址，开发测试非常的不方便。

在 Desktop 环境下，可以使用 host.docker.internal docker 提供的特殊 DNS 访问宿主机。

如果是 Linux 环境还可以使用 docker 提供的 host networking，将容器的端口直接发布到宿主机上。

host networking 方法只能用于Linux环境下的docker，不支持 Docker Desktop for Mac，Docker Desktop for Windows，或 Docker EE for Windows Server。

举个例子：如果 Dockerfile EXPOSE的端口是 80，那么使用host networking方式 启动容器，就可以直接用宿主机的ip通过80端口访问这个服务，不需要指定 --port。同时容器也可以直接访问宿主机其他端口的服务，不需要通过内网ip。

方法很简单，命令启动时，加上`--network host`就可以了

```sh
docker run --rm --network host nginx:alpine
```

在 docker-compose.yml 中使用

```yml
version: '2'
services:
  nginx:
    image: nginx:alpine
    network_mode: "host"
    volumes:
      - './html:/usr/share/nginx/html'
      - './conf:/etc/nginx'
    restart: always
```

mac和windows在18.03版本后，可以使用host.docker.internal访问宿主机

## docker启动mysql

```sh
docker run --restart=always --privileged=true  \
-v ./mysql/data:/var/lib/mysql \
-v ./mysql/logs:/var/log/mysql \
-v ./mysql/my.cnf:/etc/mysql/my.cnf  \
-p 3306:3306 --name my-mysql \
-e MYSQL_ROOT_PASSWORD=123456789 -d mysql
```

-v：主机和容器的目录映射关系，":"前为主机目录，之后为容器目录
--restart=always： 当Docker 重启时，容器会自动启动。
--privileged=true：容器内的root拥有真正root权限，否则容器内root只是外部普通用户权限

注意：启动mysql报如下错误，那是因为MYSQL新特性secure_file_priv对读写文件的影响。

```sh
ERROR: mysqld failed while attempting to check config
command was: "mysqld --verbose --help"

mysqld: Error on realpath() on '/var/lib/mysql-files' (Error 2 - No such file or directory)
2019-09-14T09:52:51.015937Z 0 [ERROR] [MY-010095] [Server] Failed to access directory for --secure-file-priv. Please make sure that directory exists and is accessible by MySQL Server. Supplied value : /var/lib/mysql-files
2019-09-14T09:52:51.018328Z 0 [ERROR] [MY-010119] [Server] Aborting
```

解决问题

- windows下：修改my.ini 在[mysqld]内加入secure_file_priv=/var/lib/mysql
- linux下：修改my.cnf 在[mysqld]内加入secure_file_priv=/var/lib/mysql

## 使用docker管理机密信息

使用docker secret管理机密信息, 首先需要启动swarm

```sh
docker swarm init
```

当前使用到的主要是mysql数据库密码、网站证书和私钥、其他密钥等

```sh
Usage:  docker secret create [OPTIONS] SECRET [file|-]

Create a secret from a file or STDIN as content

Options:
  -d, --driver string            Secret driver
  -l, --label list               Secret labels
      --template-driver string   Template driver
```

```sh
sudo docker secret create gwq5210.com.crt gwq5210.com.crt
sudo docker secret create gwq5210.com.key gwq5210.com.key
```

- 参考： [docker secrets](https://docs.docker.com/engine/swarm/secrets/)