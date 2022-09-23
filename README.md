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
