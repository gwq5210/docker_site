# 私密信息

## 证书和私钥

certs目录存放的是一个自签名的证书，使用elasticsearch工具生成

```sh
./setup_certs.sh

# or

docker-compose run -it --rm setup_certs
```

生成内容如下

```text
certs
├── ca
│   ├── ca.crt
│   └── ca.key
├── ca.zip
├── certs.zip
├── gwq5210.com
│   ├── gwq5210.com.crt  # 可以使用权威机构颁发的证书替换
│   └── gwq5210.com.key
└── instances.yml
```

gwq5210.com.crt和gwq5210.com.key用于nginx和elasticsearch的https

```sh
docker secret create gwq5210.com.crt certs/gwq5210.com/gwq5210.com.crt
docker secret create gwq5210.com.key certs/gwq5210.com/gwq5210.com.key
```

## elasticsearch密码

```sh
echo "a123456789" | docker secret create elasticsearch_bootstrap_password.txt -
echo "a123456789" | docker secret create elasticsearch_keystore_password.txt -
```

## filebrowser密码

filebrowser密码可以使用初始密码admin，然后再网页端进行修改

密码保存在filebrowser.db中，不确定是否加密

## mirai密码

```sh
echo "2423087292" | docker secret create mirai_bot_qq.txt -
echo "d41d8cd98f00b204e9800998ecf8427e" | docker secret create mirai_bot_qq_password.txt -
echo "a123456789" | docker secret create mirai_verify_key.txt -
```

## mysql密码

```sh
echo "a123456789" | docker secret create mysql_root_password.txt -
```

## scrapyd密码

```sh
echo "gwq5210" | docker secret create scrapyd_username.txt -
echo "a123456789" | docker secret create scrapyd_password.txt -
```

## tank密码

tank当前不需要设置密码，可以在网页端设置，密码保存在mysql数据库中

## v2ray密码

```sh
echo "ffffffff-ffff-ffff-ffff-ffffffffffff" | docker secret create v2ray_uuid.txt -
```

## 一键启动

### 设置秘钥(必须，设置一次即可)

```sh
# 生成自签名证书和私钥
# 这一步可以省略，修改为申请到的免费ssl证书替换
./set_certs.sh

# 设置elasticsearch和kibana的keystore文件
./set_keystore.sh
```

### 设置docker secrets

```sh
./setup.sh
```

### 启动所有服务

```sh
./start.sh
./stop.sh
./restart.sh
```
