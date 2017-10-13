//
//  walletTests.swift
//  walletTests
//
//  Created by Ammy Pandey on 24/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import XCTest

@testable import wallet

class walletTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testSignUp(){
        //let addUser = Database_Manager.init()
        let add: Database_Modal = Database_Modal()
        add.fullname = "rajesh kumar"
        add.userId = 99
        add.username = "rajesh"
        add.email = "r@gmail.com"
        add.password = "Rajesh@12345"
        let save = Database_Manager.getInstance().insertUserManagmentData(info: add)
        if save{
            print("data save")
        }else {
            print ("not save")
        }
    }
    
    func testLogin(){
        var userExist: Database_Modal = Database_Modal()
        userExist.username = "rajesh"
        userExist.password = "Rajesh@12345"
        let logUser = Database_Manager.getInstance().fetchUserManagmentData(info: userExist)
        if logUser.count > 0{
            userExist = logUser.object(at: 0) as! Database_Modal
            print(userExist.username)
            print(userExist.id)
            print(userExist.email)
        }
        else{
            print("data not reterive")
        }
            
        }
    func testAddIncome(){
        let userExist: Database_Modal = Database_Modal()
        userExist.username = "rajesh"
        userExist.password = "Rajesh@12345"
        let logUser = Database_Manager.getInstance().fetchUserManagmentData(info: userExist)
        if logUser.count > 0{
            let addIncome:Database_Modal = Database_Modal()
            addIncome.date = String(24/08/2017)
            addIncome.amount = Double(4500)
            addIncome.category = "Rent"
            addIncome.detail = "Got rent from shop"
            addIncome.id = 99
            addIncome.status = "Income"
            let save = Database_Manager.getInstance().insertPassbookData(info: addIncome)
            if save{
                print("saved")
            }else{
                print("Not saved")
            }

        }
        else{
            print("data not reterive")
        }
        
    }
    
}
