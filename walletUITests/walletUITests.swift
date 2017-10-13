//
//  walletUITests.swift
//  walletUITests
//
//  Created by Ammy Pandey on 23/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import XCTest

class walletUITests: XCTestCase {
        
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
    
    
    func testLogin(){
        
        let app = XCUIApplication()
        //app.buttons["Clear text"].tap()
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("amitabh1")
        
        app.secureTextFields["Password"].tap()
        app.typeText("Ammy@12345")
        app.buttons["Login"].tap()
       // app.tables["Empty list"].tap()
        app.navigationBars["Home"].buttons["Item"].tap()
        app.tables.staticTexts["LogOut"].tap()
        app.alerts["LogOut"].buttons["Confirm"].tap()
        
    }
    
    func testSignup(){
        XCUIApplication().buttons["SignUp"].tap()
        let app = XCUIApplication()
        app.textFields["Full Name"].tap()
       // fullNameTextField.tap()
        app.typeText("Abcd")
        
        app.textFields["Username"].tap()
        //usernameTextField.tap()
        app.typeText("abcd")
        
        app.textFields["Email"].tap()
        //emailTextField.tap()
        app.typeText("a@gmail.com")
        
        app.secureTextFields["Password"].tap()
       // passwordSecureTextField.tap()
        app.typeText("Abcd@12345")
        
        app.secureTextFields["Confirm Password"].tap()
        //confirmPasswordSecureTextField.tap()
        app.typeText("Abcd@12345")
        app.buttons["Save"].tap()
       // app.alerts["Alert"].buttons["OK"].tap()
        
    }
    
    func testEntriesAdd(){
        
        let app = XCUIApplication()
        //app.buttons["Clear text"].tap()
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("amitabh1")
        
        app.secureTextFields["Password"].tap()
        app.typeText("Ammy@12345")
        app.buttons["Login"].tap()
        //app.tables["Empty list"].tap()
        
        //Income Add
        app.navigationBars["Home"].buttons["Item"].tap()
        app.tables.staticTexts["Add Income"].tap()
    
        app.textFields["Date"].tap()
        app.toolbars.buttons["Done"].tap()
        
        app.textFields["Amount"].tap()
        //amountTextField.tap()
        app.typeText("1000000")
        
        app.textFields["Category"].tap()
        app.pickerWheels["Salary"].swipeUp()
        
        app.textFields["Details"].tap()
        //detailsTextField.tap()
        app.typeText("Got rent from Hotels")
        
        //let addIncomeNavigationBar = app.navigationBars["Add Income"]
        app.buttons["Save"].tap()
        app.alerts["Alert!"].buttons["OK"].tap()
        app.buttons["menu btn"].tap()
        
        app.tables
        app.staticTexts["Home"].tap()
        
        app.segmentedControls.buttons["Income"].tap()
        //incomeButton.tap()
        
        //let app2 = app
        app.buttons["Expenses"].tap()
        //app.tap()
        app.buttons["All"].tap()
        app.navigationBars["Home"].buttons["Item"].tap()
        app.staticTexts["LogOut"].tap()
        app.alerts["LogOut"].buttons["Confirm"].tap()
        
        
    }
}
