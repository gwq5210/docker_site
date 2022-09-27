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

## 宿主机访问容器内服务失败

```sh
# v2ray服务
curl http://localhost:10000 -v

curl: (56) Recv failure: Connection reset by peer
```

原因是docker内监听的是127.0.0.1, 需要修改为0.0.0.0才可以

## docker修改镜像源

几个速度比较快的镜像地址
Docker 官方中国区: [https://registry.docker-cn.com](https://registry.docker-cn.com)
网易: [http://hub-mirror.c.163.com](http://hub-mirror.c.163.com)
中科大: [https://docker.mirrors.ustc.edu.cn](https://docker.mirrors.ustc.edu.cn)

### macos

Docker for Mac客户端添加registry-mirrors设置

```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ]
}
```

### linux

修改文件`/etc/docker/daemon.json`, 添加registry-mirrors设置

该文件默认不存在

```json
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
```

## Get into the Docker VM

When using Docker Desktop for Mac and Windows | Docker - https://www.docker.com/products/docker-desktop, you’re actually using a tiny (custom) Alpine Linux running in a special xhyve VM on macOS or Windows. There’s so much cool stuff happening, you’re meant to forget it’s still running on a Linux kernel.

There are some ways to get into the Docker VM on Mac.

### Usages

2021 Update: Easiest option is Justin’s repo and image

Just run this from your Mac terminal and it’ll drop you in a container with full permissions on the Docker VM. This also works for Docker for Windows for getting in Moby Linux VM (doesn’t work for Windows Containers).

```sh
docker run -it --rm --privileged --pid=host justincormack/nsenter1
```

more info: GitHub - justincormack/nsenter1: simple nsenter to namespaces of pid 1 - [https://github.com/justincormack/nsenter1](https://github.com/justincormack/nsenter1)

- Option 1 (hard way): use netcat

```sh
nc -U ~/Library/Containers/com.docker.docker/Data/debug-shell.sock
```

Exit the shell with exit.

- Option 2 (easier): Use nsenter in priviledged container

```sh
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

Phil Estes (Docker Maintainer) says:

it’s running a container (using the debian image. nothing special about it other than it apparently has nsenter installed), with pid=host (so you are in the process space of the mini VM running Docker4Mac), and then nsenter says “whatever is pid 1, use that as context, and enter all the namespaces of that, and run a shell there"

- Option 3 (easist): run nsenter from a pre-built image. From Justin Cormack (Docker Maintainer)

```sh
docker run -it --rm --privileged --pid=host justincormack/nsenter1
```

### References

[1] [GitHub - justincormack/nsenter1: simple nsenter to namespaces of pid 1](https://github.com/justincormack/nsenter1)
[2] [justincormack/nsenter1](https://hub.docker.com/r/justincormack/nsenter1)
[3] [Docker Desktop for Mac Commands for Getting Into The Local Docker VM](https://www.bretfisher.com/docker-for-mac-commands-for-getting-into-local-docker-vm/)
[4] [Getting a Shell in the Docker Desktop Mac VM · GitHub](https://gist.github.com/BretFisher/5e1a0c7bcca4c735e716abf62afad389)
[5] [Docker Desktop for Mac and Windows | Docker](https://www.docker.com/products/docker-desktop)

## windows docker volume位置

浏览器中打开如下链接

```text
\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\
```
