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
docker secret create gwq5210.com.crt gwq5210.com.crt
docker secret create gwq5210.com.key gwq5210.com.key
```

## elasticsearch密码

```sh
echo "a123456789" | docker secret create elasticsearch_bootstrap_password.txt -
echo "a123456789" | docker secret create elasticsearch_keystore_password.txt -
```

## elasticsearch密码

```sh
echo "a123456789" | docker secret create elasticsearch_bootstrap_password.txt -
echo "a123456789" | docker secret create elasticsearch_keystore_password.txt -
```

## mysql密码

```sh
echo "a123456789" | docker secret create mysql_root_password.txt -
```




## 一键启动

### 设置秘钥

```sh
./start.sh
# or
docker-compose up --build -d
```
