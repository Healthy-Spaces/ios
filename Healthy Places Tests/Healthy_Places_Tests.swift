//
//  Healthy_Places_Tests.swift
//  Healthy Places Tests
//
//  Created by Samuel Lichlyter on 5/30/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import XCTest

@testable import Healthy_Places

class Healthy_Places_Tests: XCTestCase {
    
    let testSession = NetworkSession()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //    func testExample() {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
    func testStringConversion() {
        let string = "{\"name\":\"James\"}"
        let conversionDictionary = convertToDictionary(text: string)
        
        XCTAssertEqual("James", conversionDictionary?["name"] as? String)
    }
    
//    func testLogin() {
//
//        let expectedID = 1
//
//        let data = NSMutableDictionary()
//
//        let exp = expectation(description: "Sending/Receiving data")
//        var rCode = -1
//        var rResponse = ""
//
//        upload(data: data) { (response, code) in
//            rCode = code
//            rResponse = response
//            exp.fulfill()
//        }
//
//        self.waitForExpectations(timeout: 5) { (error) in
//            XCTAssert(rCode == 0)
//
//            if (rCode == 0) {
//                let responseDict = convertToDictionary(text: rResponse)
//                let idString = responseDict?["uid"] as? String
//
//                let id = Int(idString!)
//
//                XCTAssertEqual(expectedID, id)
//            }
//        }
//    }
    
    func testSerialization() {
        
        // test setup
        let writeExp = expectation(description: "write data")
        var sSuccess = false
        let data = "dataObjectGoesHere".data(using: .utf8)!
        
        let json = NSMutableDictionary()
        json.setObject("newUser", forKey: "userID" as NSCopying)
        json.setObject(data, forKey: "data" as NSCopying)
        
        // save
        saveJSONData(data: json, completion: { (success) in
            sSuccess = success
            writeExp.fulfill()
        })
        
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssert(sSuccess)
        }
    }
    
    func testGetNameAndEmail() {
        let networkExp = expectation(description: "Getting Data from Network")
        var rCode = -1
        var rResponse = ""
        let json = NSMutableDictionary()
        json.setObject(1, forKey: "uid" as NSCopying)
        json.setObject("getNameAndEmail", forKey: "task" as NSCopying)
        
        upload(data: json) { (response, code) in
            rCode = code
            rResponse = response
            networkExp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssert(rCode == 0)
            
            if rCode == 0 {
                let rDict = convertToDictionary(text: rResponse)
                let email = rDict?["email"] as? String
                let givenName = rDict?["givenName"] as? String
                let familyName = rDict?["familyName"] as? String
                
                let name = givenName! + " " + familyName!
                XCTAssertEqual(name, "Sam Lichlyter ")
                XCTAssertEqual(email, "lichlyts@oregonstate.edu")
            }
        }
    }
    
    //    func testUserRegistration() {
    //
    //
    //        let data = NSMutableDictionary()
    //        let registrationData = convertToDictionary(text: registrationString)
    //        data.setObject("newUser", forKey: "userID" as NSCopying)
    //        data.setObject(registrationData!, forKey: "data" as NSCopying)
    //        var rResponse = ""
    //        var rCode = -1
    //
    //        let uploadExp = expectation(description: "upload")
    //
    //        upload(data: data) { (response, code) in
    //            if code == 0 {
    //                rResponse = response
    //                rCode = code
    //                uploadExp.fulfill()
    //            }
    //        }
    //
    //        self.waitForExpectations(timeout: 5) { (error) in
    //            let responseDictionary = convertToDictionary(text: rResponse)
    //            let newID = responseDictionary?["uid"] as? Int
    //            
    //            XCTAssertEqual(rCode, 0)
    //            XCTAssertGreaterThan(newID!, -1)
    //        }
    //    }
    
}
