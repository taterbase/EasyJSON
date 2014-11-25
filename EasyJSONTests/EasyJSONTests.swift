//
//  EasyJSONTests.swift
//  EasyJSONTests
//
//  Created by George Shank on 11/24/14.
//  Copyright (c) 2014 Meshable. All rights reserved.
//

import EasyJSON
import XCTest

class EasyJSONTests: XCTestCase {
    var json = EasyJSON(json: "{\"name\": \"henry\", \"age\": 23, \"friends\": [{\"name\": \"john\", \"friendly\": true}]}")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
        // This is an example of a functional test case.
        XCTAssert(json["name"].string == "henry", "should be able to retrieve string values")
        XCTAssert(json["age"].number == 23, "should be able to retrieve number values")
        XCTAssert(json["friends"].array?.count == 1, "should be able to retrieve arrays")
        XCTAssert(json["friends"][0]["friendly"].boolean!, "should be able to grab boolean values")
    }
    
    
}
