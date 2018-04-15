//
//  SingaporePowerTests.swift
//  SingaporePowerTests
//
//  Created by User on 4/15/18.
//  Copyright © 2018 VK. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import SingaporePower
//@testable import PSIModel

class SingaporePowerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        testController()
        testModel()
        testView()
    }
    
    func testController () {
        let v = ViewController()
    
        XCTAssertEqual(v.createDate(data: [:]),[], "Data Set Correct")
        expect(v.createDate(data: [:])).to(equal([]), description: "Data Set Correct")
        
        expect(v.createDate(data: [:])).to(equal([]))
        let psiModel = PSIModel()
        expect(v.populateReadings(data: [:], model: psiModel)).to(beAKindOf(PSIDetail.self))
    }
    
    
    func testModel() {
        let psiModel = PSIModel()
        expect(psiModel.name).to(beAKindOf(String.self))
        expect(psiModel.latittude).to(beAKindOf(Double.self))
        expect(psiModel.longittude).to(beAKindOf(Double.self))
        expect(psiModel.detail).to(beAKindOf(PSIDetail.self))
    }
    
    func testView() {
        let customMapView = CustomMapView()
         expect(customMapView.getPSIModelWithName(name: nil)).to(beNil())
         expect(customMapView.getPSIModelWithName(name: "")).to(beNil())
         let psiModel = PSIModel()
         psiModel.name = "TestName"
         customMapView.dataArray = [psiModel]
         expect(customMapView.getPSIModelWithName(name: "TestName")).to(beAKindOf(PSIModel.self))
        
//        let customPopupView = CustomPopupView()
//        expect(customPopupView.populatePSIReadings(readings: nil)).
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
