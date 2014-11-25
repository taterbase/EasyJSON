//
//  EasyJSON.swift
//  EasyJSON
//
//  Created by George Shank on 11/24/14.
//  Copyright (c) 2014 Meshable. All rights reserved.
//

import Foundation
import JavaScriptCore

var EasyJSONJavaScript = "function isObject(a){return!!Object.prototype.toString.call(a).match(/\\[object Object\\]/)}function isArray(a){return Array.isArray(a)}function isString(a){return\"string\"==typeof a}function isNumber(a){return\"number\"==typeof a}function isBoolean(a){return\"boolean\"==typeof a}function parse(a){var b={};\"string\"==typeof a&&(a=JSON.parse(a));for(var c in a){var d,e,f=a[c];b[c]={EJSONValue:f},isObject(f)?(d=\"object\",e=JSON.stringify(f)):isArray(f)?(d=\"array\",e=JSON.stringify(f)):isString(f)?(d=\"string\",e=f):isNumber(f)?(d=\"number\",e=f.toString()):isBoolean(f)&&(d=\"boolean\",e=f.toString()),b[c].EJSONType=d,b[c].EJSONString=e}return b}var EJSONParser={parse:parse};"

class EasyJSON {
    let context = JSContext()
    
    init (json: String) {
        context.evaluateScript(EasyJSONJavaScript)
        context.evaluateScript("EJSON = EJSONParser.parse(" + json + ")")
        println(json)
    }
    
    var string: String?
    var number: Double?
    var object: AnyObject?
    var date: NSDate?
    var array: Array<AnyObject>?
    var boolean: Bool?
    
    subscript (index: Int) -> EasyJSON {
        var result = context.objectForKeyedSubscript("EJSON").objectAtIndexedSubscript(index)
        return evaluateResult(result)
    }
    
    subscript (key: String) -> EasyJSON {
        var result = context.objectForKeyedSubscript("EJSON").objectForKeyedSubscript(key)
        return evaluateResult(result)
    }
    
    private func evaluateResult(result: JSValue) -> EasyJSON {
        var g = EasyJSON(json: result.objectForKeyedSubscript("EJSONString").toString())
        
        switch result.objectForKeyedSubscript("EJSONType").toString() {
        case "string":
            g.string = result.objectForKeyedSubscript("EJSONValue").toString()
            break
        case "number":
            g.number = result.objectForKeyedSubscript("EJSONValue").toNumber().doubleValue
            break
        case "object":
            g.object = result.objectForKeyedSubscript("EJSONValue").toDictionary()
            break
        case "date":
            g.date = result.objectForKeyedSubscript("EJSONValue").toDate()
            break
        case "array":
            g.array = result.objectForKeyedSubscript("EJSONValue").toArray()
            break
        case "boolean":
            g.boolean = result.objectForKeyedSubscript("EJSONValue").toBool()
            break
        default:
            break
        }
        return g
    }
}