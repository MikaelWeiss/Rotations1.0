//
//  RotationsUITests.swift
//  RotationsUITests
//
//  Created by Mikael Weiss on 8/12/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import XCTest

class RotationsUITests: XCTestCase {
        
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
    
    func testExample() {
        
        let app = XCUIApplication()
        let rotationsNavigationBar = app.navigationBars["Rotations"]
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        
        app.navigationBars["Rotations"].buttons["icons8 settings"].tap()
        let manualRotateButtonSwitch = tablesQuery2.switches["Manual Rotate Button"]
        switch (manualRotateButtonSwitch.value) as! Bool {
        case false:
            manualRotateButtonSwitch.tap()
        default:
            print("All Good")
        }
        
        app.navigationBars["Rotations.Settings"].buttons["Rotations"].tap()
        
        app.navigationBars["Rotations.Settings"].buttons["Rotations"].tap()
        
        let clearTextTextField = tablesQuery.textFields[" Add Group"]
        clearTextTextField.tap()
        clearTextTextField.typeText("UITests Group")
        app.typeText("\r")
        rotationsNavigationBar.buttons["Done"].tap()
        tablesQuery.staticTexts["UITests Group"].tap()
        
        let addPersonTextField = tablesQuery.cells.textFields[" Add Person"]
        addPersonTextField.tap()
        addPersonTextField.typeText("mikael")
        app.typeText("\r")
        
        let addAssignmentTextField = tablesQuery.textFields[" Add Assignment"]
        addAssignmentTextField.tap()
        addAssignmentTextField.typeText("test")
        app.typeText("\r")
        
        addPersonTextField.tap()
        addPersonTextField.typeText("rachel")
        app.typeText("\r")
        
        addAssignmentTextField.tap()
        addAssignmentTextField.typeText("test 2")
        app.typeText("\r")
        
        let uitestsGroupNavigationBar = app.navigationBars["UITests Group"]
        uitestsGroupNavigationBar.buttons["Done"].tap()
        
        let icons8SynchronizeButton = uitestsGroupNavigationBar.buttons["icons8 synchronize"]
        icons8SynchronizeButton.tap()
        icons8SynchronizeButton.tap()
        uitestsGroupNavigationBar.children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        app.navigationBars["Rotations"].buttons["Edit"].tap()
        tablesQuery.buttons["Delete UITests Group"].tap()
        tablesQuery.buttons["Delete"].tap()
        
    }
    
}
