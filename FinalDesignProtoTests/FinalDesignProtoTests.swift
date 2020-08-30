//
//  FinalDesignProtoTests.swift
//  FinalDesignProtoTests
//
//  Created by Owen Malcolmson-Priest on 19/11/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import XCTest

class FinalDesignProtoTests: XCTestCase {

    override func setUp() {
     //   DBAccess.sharedInstance
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    
    func testGettingSpeakers() {
        let speakers = DBAccess.sharedInstance.getSpeakers()
        XCTAssert(speakers.count == 21)
        XCTAssert(speakers[0].name == "Adam Rush")
    }
    
    func testGettingMonday(){
        let Monday = DBAccess.sharedInstance.getMonday()
        XCTAssert(Monday.count == 2)
        XCTAssert(Monday[0].id == "arkit")
    }
    
    func testGettingTuesday(){
        let Tuesday = DBAccess.sharedInstance.getTuesday()
        XCTAssert(Tuesday.count == 15)
        XCTAssert(Tuesday[0].id == "registration")
    }
    
    func testGettingWednesday(){
        let Wednesday = DBAccess.sharedInstance.getWednesday()
        XCTAssert(Wednesday.count == 11)
        XCTAssert(Wednesday[0].id == "fasttech1")
    }
    
    func testGettingThursday(){
        let Thursday = DBAccess.sharedInstance.getThursday()
        XCTAssert(Thursday.count == 6)
        XCTAssert(Thursday[0].id == "fasttech2")
    }
    
    func testgettingSpecificSpeaker(){
        var speaker = DBAccess.sharedInstance.getSpecificSpeaker(speaker: "ChrisPrice")
        XCTAssert(speaker.name == "Chris Price")
    }
    
    func testGettingSpeakersSession(){
        var session = DBAccess.sharedInstance.getSpeakersSessions(speaker: "ChrisPrice")
        XCTAssert(session[0] == "Decoding Codable")
    }
    
    func testGettingSessionDetails(){
        var session = DBAccess.sharedInstance.getSessionDetails(sessionName: "Decoding Codable")
        XCTAssert(session.speaker == "ChrisPrice")
    }
    
    
    
//    func testGetCoords(){
//        let coords = DBAccess.sharedInstance.getCoOrds(location: "b23")
//        XCTAssert(coords.count == 1)
//        XCTAssert(coords[0] == "52.416367")
//        XCTAssert(coords[1] == "4.066299")
//    }
    
   // func testGetting
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    

}





