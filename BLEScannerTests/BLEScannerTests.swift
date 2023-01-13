//
//  BLEScannerTests.swift
//  BLEScannerTests
//
//  Created by jeffn on 1/11/23.
//

import XCTest
@testable import BLEScanner

final class BLEScannerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBLEService() throws {
        let bleService = BLEService(service: nil)
        XCTAssert(bleService.name == "")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
