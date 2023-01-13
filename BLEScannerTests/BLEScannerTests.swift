//
//  BLEScannerTests.swift
//  BLEScannerTests
//
//  Created by jeffn on 1/11/23.
//

import XCTest
@testable import BLEScanner

final class BLEScannerTests: XCTestCase {
    
    func testBLEService() throws {
        // Test the name computed property
        let bleService = BLEService(service: nil)
        XCTAssert(bleService.name == "")
    }
}
