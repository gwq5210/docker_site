module.exports.parse = (raw, { axios, yaml, notify, console }) => {
    const obj = yaml.parse(raw)
    var proxy_groups = obj["proxy-groups"]
    const names = new Set(['我的代理', '节点选择', '自动选择', '故障转移', 'ChatGPT', 'TikTok']);
    proxy_groups.forEach((item, index, arr) => {
        if (!names.has(item.name)) {
            item.proxies.unshift('我的代理')
        }
    })
    var rules = obj.rules
    rules.forEach((item, index, arr) => {
        if (item.startsWith('MATCH,')) {
            arr[index] = 'MATCH,我的代理'
        }
    })
    return yaml.stringify(obj)
}