//
//  BLEScannerUITests.swift
//  BLEScannerUITests
//
//  Created by jeffn on 1/11/23.
//

import XCTest

final class BLEScannerUITests: XCTestCase {
    
    func testHomeView() throws {
        // Launch the app and navigate to the second view
        let app = XCUIApplication()
        app.launch()
        app.buttons["Scan for BLE Devices"].tap()
        app.navigationBars["Devices"].buttons["Home"].tap()
    }
}
