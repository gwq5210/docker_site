## 申请Let's Encrypt证书

[Let's Encrypt](https://letsencrypt.org)是一个免费的、自动化的、开放的证书颁发机构。截至2018年9月，它的全球SSL证书市场份额已超过50%，得到主流浏览器和厂商的认可与支持。

Let's Encrypt证书提供免费的申请，但没有高额的安全保险，不具备点对点的技术支持，而且申请过程比较复杂，适合具有一定的专业知识的个人站长申请。并且每次申请到的SSL证书有效期只有90天，但是可以通过脚本实现提前自动续约达到自动化永久免费使用的目的。

在2018年5月，Let's Encrypt发布了[免费泛域名通配符SSL证书](https://community.letsencrypt.org/t/acme-v2-and-wildcard-certificate-support-is-live/55579) ，在HTTPS全面普及的当下，越来越多的开发者选择了Let's Encrypt证书。

想要实现免费泛域名SSL证书申请及其自动续签，需要以下材料：

- 一枚域名
- 一台服务器（用以执行申请与自动续签脚本，且Web服务运行在此服务器上）
- 本文将以 *.gwq5210.com 为例进行泛域名证书申请演示

### 证书申请

Let's Encrypt官方提供了一系列的申请方法文档，但流程比较复杂，为了简化申请流程，我们可以在Github上找到这个仓库[acme.sh](https://github.com/Neilpang/acme.sh)

acme.sh 的具体使用说明见：[acme.sh说明](https://github.com/Neilpang/acme.sh/wiki/说明)

接下来，我们就利用 acme.sh 对证书进行申请。

#### 安装 acme.sh

进入服务器，执行命令:

```sh
curl  https://get.acme.sh | sh
```

普通用户和root用户都可以安装使用，安装脚本其实是进行了如下操作:

- 会把 acme.sh 安装到你所执行命令用户的用户目录下： ~/.acme.sh/
- 会创建 bash 的 alias，方便你的使用：alias > acme.sh=~/.acme.sh/acme.sh
- 会自动为你创建 cronjob 脚本，每天零点自动检测所有的证书，如果某证书快过期需要更新，则会自动更新该证书。

安装过程不会污染已有的系统任何功能和文件，所有后续的修改都将限制在安装目录中：~/.acme.sh/

#### 验证域名并生成证书

acme.sh 实现了 acme 协议支持的所有验证协议，通常一般有几种方式验证域名：HTTP文件验证 和 DNS验证 等，具体验证方式可查阅脚本github文档。

##### HTTP文件验证

```sh
acme.sh --issue -d gwq5210.com -d *.gwq5210.com -w /home/webroot
```

注意：对于通配符证书需要加 -d 域名 -d *.域名 两个参数-w 即webroot，为该 域名 通过http所访问到的本地目录上面这段过程将会在 /home/webroot 创建一个 .well-known 的文件夹，同时 Let’s Encrypt 将会通过你要注册的域名去访问那个文件来确定权限，它可能会去访问 http://gwq5210.com/.well-known/ 这个路径，验证成功会自动清理。

##### DNS-API验证

‌通过DNS服务器提供 key 与 secret 实现自动验证，详情‌https://github.com/Neilpang/acme.sh/tree/master/dnsapi‌

‌例如，在腾讯云解析的域名，请前往 https://www.dnspod.cn/console/user/security 控制台中申请子账号 API Token 并执行命令

```sh
export DP_Id="6*ID*0"
export DP_Key="aa445e***TOKEN***5fe26e"
acme.sh --issue -d gwq5210.com -d *.gwq5210.com --dns dns_dp
```

注意：对于通配符证书需要加 -d 域名 -d *.域名 两个参数DP_Id 和 DP_Key 将会保存在 ~/.acme.sh/account.conf

执行上述命令后，证书文件将会自动申请被存放在 ~/.acme.sh/ 对应的域名文件夹中，如：~/.acme.sh/gwq5210.com 。后续 acme.sh 将会自动更新该文件夹内的证书。

#### 部署nginx

参考：https://github.com/Neilpang/acme.sh/wiki/说明

##### 拷贝证书

$ acme.sh --install-cert -d gwq5210.com \
--key-file       /etc/nginx/ssl/gwq5210.com.key \
--fullchain-file /etc/nginx/ssl/gwq5210.com.cer \
--reloadcmd      'service nginx force-reload'

注意：通过该命令可将 ~/.acme.sh/gwq5210.com 内的证书copy到指定位置/etc/nginx 为nginx服务器实际的地址(可修改为自己服务器对应的地址)service nginx force-reload 为nginx重启命令(可修改为自己服务器对应的命令)，force-reload 会重载证书后续 acme.sh 签发了新证书后就自动完成该拷贝过程

##### 配置nginx

```sh
‌vim /etc/nginx/conf.d/gwq5210.com.conf
```

```text
# http(80) -> https(443/ssl)
server {
    listen 80;
    server_name gwq5210.com;
    rewrite ^(.*)$ https://$host$request_uri;
}

# gwq5210.com
server {
  listen 443;
  server_name gwq5210.com;
  ssl on;
  ssl_certificate ssl/gwq5210.com.cer;
  ssl_certificate_key ssl/gwq5210.com.key;

  location / {
      # todo
  }
}
```

## 解决 Nginx Let's Encrypt HTTPS 证书 错误： 服务器缺少中间证书

Nginx配置Let's Encrypt 证书的确存在中间证书缺失问题

本文介绍如何解决这一问题

这里证书用的是 Let's Encrypt 通配符证书

首先检查 是否存在这一问题

检测地址: [www.myssl.cn](https://www.myssl.cn/tools/check-server-cert.htm)

根据调查Nginx不像是Apache有专门的参数配置中间证书

```text
ssl_certificate /run/secrets/gwq5210.com.crt; # 证书
ssl_certificate_key /run/secrets/gwq5210.com.key; # 私钥
```

正确的格式是分为三段

分别代表 服务器层 中间层 root层

-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----

而实际上一般 Let's Encrypt 生成的证书
fullchain.pem 默认都是两段


-----BEGIN CERTIFICATE-----


...


-----END CERTIFICATE-----


-----BEGIN CERTIFICATE-----


...


-----END CERTIFICATE-----


### 解决

其实具体缺失中间证书是不是一个问题, 有什么后果，都尚未可知。

只是抱着能解决就解决的心态去调查解决的。

首先先找到 Let's Encrypt 生成的文件

```text
ca.cer
fullchain.cer  # 包含服务器层 中间层 root层
gwq5210.com.cer  # 只包含服务器层
gwq5210.com.conf
gwq5210.com.csr
gwq5210.com.csr.conf
gwq5210.com.key
```

将 fullchain.cer 内容配置到nginx的证书位置即可

再次去到一开始检测的网址, 进行检测就正常了
