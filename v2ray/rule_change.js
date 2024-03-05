module.exports.parse = (raw, { yaml }) => {
    const rawObj = yaml.parse(raw)
    rawObj.proxy-groups
    return yaml.stringify({ ...rawObj, 'proxy-groups': groups, rules })
}