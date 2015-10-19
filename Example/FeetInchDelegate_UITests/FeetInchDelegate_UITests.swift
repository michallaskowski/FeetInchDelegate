//
//  FeetInchDelegate_UITests.swift
//  FeetInchDelegate_UITests
//
//  Created by mlaskowski on 19/10/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import XCTest
class FeetInchDelegate_UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDelegate() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        let deleteKey = app.keys["Delete"]
        let lengthTextField = app.textFields["length"]
        
        lengthTextField.tap()
        lengthTextField.typeText("15")
        XCTAssertEqual(lengthTextField.value as? String, "1 ft 5 in.")
        
        deleteKey.tap()
        lengthTextField.typeText("123456789")
        XCTAssertEqual(lengthTextField.value as? String, "1 ft 1 in.")
        
        deleteKey.tap()
        lengthTextField.typeText("22136547890")
        XCTAssertEqual(lengthTextField.value as? String, "1 ft 2 in.")

        deleteKey.doubleTap()
        deleteKey.tap()
        lengthTextField.typeText("58")
        XCTAssertEqual(lengthTextField.value as? String, "5 ft 8 in.")

    }
    
}
