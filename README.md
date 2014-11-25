#EasyJSON [![Build Status](https://travis-ci.org/taterbase/EasyJSON.svg)](https://travis-ci.org/taterbase/EasyJSON)
*Easy JSON parsing in Swift*

##Description
*I made this before I discovered [SwiftyJSON](https://github.com/SwiftyJSON) which has essentially the same API. The big difference is EasyJSON relies on JavaScriptCore to do most of the heavy lifting.*

Parsing with EasyJSON is meant to be as close as possible to JavaScript notation. Using square brackets you reach into the object, arrays, and access any value. If a non-existant value is accessed then `nil` is returned.

##Installation
CocoaPods is not fully supported for Swift yet. To use this library in your project you should:

1. for Projects just drag EasyJSON.swift to the project tree 
2. for Workspaces you may include the whole EasyJSON.xcodeproj

*Installation instructions inspired by [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)*

##Usage

```swift
import EasyJSON

/* ... */

var jsonStr = "{\"name\": \"henry\", \"age\": 23, \"friends\": [{\"age\": 21, \"name\": \"john\", \"friendly\": true}]}"
var json = EasyJSON(json: jsonStr)

var friendNames: [String] = []
var friendAges: [Double] = []

//Pull out strings easily
var name = json["name"].string

//Iterate through arrays easily
for var index = 0; index < json["friends"].array?.count; ++i {
  if let friendly = json["friends"][index]["friendly"].boolean {
    if friendly {
      //Numbers are returned as a Double (as per js convention)
      friendAges.append(json["friends"][index]["age"].number)
      friendNames.append(json["friends"][index]["name"].string)
    }
  }
  
  // OR if you trust your data
  
  if json["friends"][index]["friendly"].boolean! {
    friendNames.append(json["friends"][index]["name"].string)
    friendAges.append(json["friends"][index]["age"].number)
  }
}
```

___

Made with ⚡️ by [@taterbase](https://twitter.com/taterbase)
