//
//  SingaporePowerTests.swift
//  SingaporePowerTests
//
//  Created by User on 4/15/18.
//  Copyright © 2018 VK. All rights reserved.
//

import XCTest

@testable import SingaporePower
//@testable import PSIModel

class SingaporePowerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        testViewController()
    }
    
    func testViewController () {
        let v = ViewController()
        
        XCTAssertEqual(v.createDate(data: [:]),[], "Data Set Correct")
//        let psiModel = PSIModel()
//        let psiModelDetail = PSIDetail()
//        XCTAssertEqual(v.populateReadings(data: [:], model: psiModel)
//            ,psiModelDetail, "Data Set Correct")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
