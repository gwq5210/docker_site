# clash规则

[clash-rules](https://github.com/Loyalsoldier/clash-rules)
[advanced-usage-for-clash](https://docs.mebi.me/docs/advanced-usage-for-clash)
[Parsers-for-clash](https://github.com/iczrac/Parsers-for-clash)
[https://docs.gtk.pw/contents/parser.html](https://docs.gtk.pw/contents/parser.html)

```yml
parsers:
  - url: https://example.com/profile.yaml
    yaml:
      prepend-rules:
        - DOMAIN-SUFFIX,baidu.com,我的代理
        - DOMAIN-SUFFIX,baidubcr.com,我的代理
        - DOMAIN-SUFFIX,baidupan.com,我的代理
        - DOMAIN-SUFFIX,baidupcs.com,我的代理
        - DOMAIN-SUFFIX,vv.video.qq.com,我的代理
        - DOMAIN-SUFFIX,quark.cn,我的代理
        - DOMAIN-SUFFIX,aliyun.com,我的代理
        - DOMAIN-SUFFIX,yinxiang.com,我的代理
        - DOMAIN,fairplay.l.qq.com,我的代理
        - DOMAIN,livew.l.qq.com,我的代理
        - DOMAIN,vd.l.qq.com,我的代理
        - DOMAIN-SUFFIX,myqcloud.com,我的代理
        - DOMAIN-SUFFIX,tencent.com,我的代理
        - DOMAIN-SUFFIX,tencent-cloud.com,我的代理
        - DOMAIN-SUFFIX,tencent-cloud.net,我的代理
        - DOMAIN-SUFFIX,tenpay.com,我的代理
        - DOMAIN-SUFFIX,wechat.com,我的代理
        - DOMAIN-SUFFIX,qqmail.com,我的代理
        - DOMAIN-SUFFIX,qq.com,我的代理
        - DOMAIN-SUFFIX,servicewechat.com,我的代理
      prepend-proxies:
        - {name: HK_PROXY, server: you.domain.com, port: 443, type: vmess, uuid: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa, alterId: 0, cipher: auto, tls: true, network: ws, ws-opts: {path: /, headers: {Host: you.domain.com}}}
      prepend-proxy-groups:
        - name: 直连
          type: select
          proxies:
            - DIRECT
        - name: 我的代理
          type: select
          proxies:
            - HK_PROXY
      mix-object:
        dns:
          enable: false
  - url: https://example.com/profile.yaml
    code: |
      module.exports.parse = (raw, { axios, yaml, notify, console }) => {
        const obj = yaml.parse(raw)
        var proxy_groups = obj["proxy-groups"]
        proxy_groups.forEach((item, index, arr)=>{
          if (item.name !== '我的代理') {
            item.proxies.unshift('我的代理')
          }
        })
        return yaml.stringify(obj)
      }
```
