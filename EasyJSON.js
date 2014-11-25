var EJSONParser = {parse: parse}

if (module && module.exports)
  module.exports = EJSONParser

function isObject(val) {
  return !!Object.prototype.toString.call(val).match(/\[object Object\]/)
}

function isArray(val) {
  return Array.isArray(val)
}

function isString(val) {
  return (typeof val === 'string')
}

function isNumber(val) {
  return (typeof val === 'number')
}

function isBoolean(val) {
  return (typeof val === 'boolean')
}

function parse(obj) {
  var result = {}

  if (typeof obj === 'string')
    obj = JSON.parse(obj)
  
  for (var key in obj) {
    var val = obj[key]
      , type
      , string

    result[key] = {EJSONValue: val}

    if (isObject(val)) {
      type = "object"
      string = JSON.stringify(val)
    } else if (isArray(val)) {
      type = "array"
      string = JSON.stringify(val)
    } else if (isString(val)) {
      type = "string"
      string = val
    } else if (isNumber(val)) {
      type = "number"
      string = val.toString()
    } else if (isBoolean(val)) {
      type = "boolean"
      string = val.toString()
    }

    result[key]["EJSONType"] = type
    result[key]["EJSONString"] = string

  }

  return result
}
