//
//  Database_Manager.swift
//  wallet
//
//  Created by Ammy Pandey on 23/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

let sharedInstance = Database_Manager()
class Database_Manager: NSObject {

    //Mark: Use FMDdatabase for all querry of database
    var databse: FMDatabase? = nil
    
    class func getInstance() -> Database_Manager{
        if (sharedInstance.databse == nil){
            sharedInstance.databse = FMDatabase(path: DB_PathFind.getPath(filename: "database_wallet.sqlite"))
        }
        return sharedInstance
    }
    // Mark: Insert Data in database function
    
    
    func insertUserManagmentData(info: Database_Modal) -> Bool {
        sharedInstance.databse?.open()
        let insert = sharedInstance.databse?.executeUpdate("INSERT INTO USERS (FULLNAME,USERNAME,EMAIL,PASSWORD,CONFIRM_PASSWORD)VALUES(?,?,?,?,?)", withArgumentsIn: [info.fullname,info.username,info.email,info.password,info.confirmPasswd])
        sharedInstance.databse?.close()
        return insert!
    }
    
    func insertPassbookData(info: Database_Modal) -> Bool{
        sharedInstance.databse?.open()
        let insert = sharedInstance.databse?.executeUpdate("INSERT INTO PASSBOOK (ID,DATE,AMOUNT,CATEGORY,DETAIL,STATUS) VALUES (?,?,?,?,?,?)", withArgumentsIn: [info.id,info.date,info.amount,info.category,info.detail,info.status])
        sharedInstance.databse?.close()
        return insert!
    }
      
    
    //Fetch Data from USER_MANAGMENT table
    func fetchUserManagmentData(info: Database_Modal) -> NSMutableArray{
        sharedInstance.databse?.open()
        let resultSet: FMResultSet! = sharedInstance.databse?.executeQuery("SELECT * FROM USERS where USERNAME=? and PASSWORD=?", withArgumentsIn: [info.username,info.password])
        let userInfo: NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let dbModal: Database_Modal = Database_Modal()
                
                dbModal.fullname = resultSet.string(forColumn: "FULLNAME")
                dbModal.username = resultSet.string(forColumn: "USERNAME")
                dbModal.email = resultSet.string(forColumn: "EMAIL")
                dbModal.password = resultSet.string(forColumn: "PASSWORD")
                dbModal.confirmPasswd = resultSet.string(forColumn: "CONFIRM_PASSWORD")
                dbModal.userId = Int(resultSet.int(forColumn: "USER-ID"))
                
                userInfo.add(dbModal)
            }
        }
        sharedInstance.databse?.close()
        return userInfo
    }
    
   //Fetch Data from PASSBOOK table
    func fetchPassbookData(info: Database_Modal) -> NSMutableArray{
        sharedInstance.databse?.open()
        let resSet: FMResultSet! = sharedInstance.databse?.executeQuery("SELECT * FROM PASSBOOK where ID=?", withArgumentsIn: [info.id])
        let passInfo: NSMutableArray = NSMutableArray()
        if (resSet != nil) {
            while resSet.next() {
                let dbModal: Database_Modal = Database_Modal()
                
                dbModal.date = resSet.string(forColumn: "DATE")
                dbModal.amount = Double(resSet.double(forColumn: "AMOUNT"))
                dbModal.category = resSet.string(forColumn: "CATEGORY")
                dbModal.detail = resSet.string(forColumn: "DETAIL")
                dbModal.status = resSet.string(forColumn: "STATUS")
                dbModal.trans_id = Int(resSet.int(forColumn: "TRANSACTION_ID"))
                
                passInfo.add(dbModal)
            }
        }
        sharedInstance.databse?.close()
        return passInfo
    }
    
    //Mark: Delete Data from database
        func deleteDataFromPassbook(info: Database_Modal) -> Bool{
            sharedInstance.databse?.open()
            let isDeleted = sharedInstance.databse?.executeUpdate("DELETE FROM PASSBOOK WHERE TRANSACTION_ID=?", withArgumentsIn: [info.trans_id])
            sharedInstance.databse?.close()
            return isDeleted!
        }
    //Mark: Addition of Income
    func totalOfIncome(info: Database_Modal) -> NSMutableArray{
        sharedInstance.databse?.open()
        let resSet: FMResultSet! = sharedInstance.databse?.executeQuery("SELECT sum(AMOUNT) as AMOUNT FROM PASSBOOK where ID=? and STATUS='Income'", withArgumentsIn: [info.id])
        let passInfo: NSMutableArray = NSMutableArray()
        if (resSet != nil) {
            while resSet.next() {
                let dbModal: Database_Modal = Database_Modal()
                
                dbModal.amount = Double(resSet.double(forColumn: "AMOUNT"))
                //                dbModal.status = resSet.string(forColumn: "STATUS")
                
                passInfo.add(dbModal)
            }
        }
        sharedInstance.databse?.close()
        return passInfo
    }

    //Mark: Addition of Expenses
    func totalOfExpenses(info: Database_Modal) -> NSMutableArray{
        sharedInstance.databse?.open()
        let resSet: FMResultSet! = sharedInstance.databse?.executeQuery("SELECT sum(AMOUNT) as AMOUNT FROM PASSBOOK where ID=? and STATUS='Expenses'", withArgumentsIn: [info.id])
        let passInfo: NSMutableArray = NSMutableArray()
        if (resSet != nil) {
            while resSet.next() {
                let dbModal: Database_Modal = Database_Modal()
                
                dbModal.amount = Double(resSet.double(forColumn: "AMOUNT"))
                //                dbModal.status = resSet.string(forColumn: "STATUS")
                
                passInfo.add(dbModal)
            }
        }
        sharedInstance.databse?.close()
        return passInfo
    }

    //Fetch Data from PASSBOOK table
    func fetchStatusData(info: Database_Modal) -> NSMutableArray{
        sharedInstance.databse?.open()
        let resSet: FMResultSet! = sharedInstance.databse?.executeQuery("SELECT * FROM PASSBOOK where ID=? and STATUS = ?", withArgumentsIn: [info.id,info.status])
        let passInfo: NSMutableArray = NSMutableArray()
        if (resSet != nil) {
            while resSet.next() {
                let dbModal: Database_Modal = Database_Modal()
                
                dbModal.date = resSet.string(forColumn: "DATE")
                dbModal.amount = Double(resSet.double(forColumn: "AMOUNT"))
                dbModal.category = resSet.string(forColumn: "CATEGORY")
                dbModal.detail = resSet.string(forColumn: "DETAIL")
                //dbModal.status = resSet.string(forColumn: "STATUS")
                dbModal.trans_id = Int(resSet.int(forColumn: "TRANSACTION_ID"))
                
                passInfo.add(dbModal)
            }
        }
        sharedInstance.databse?.close()
        return passInfo
    }

}

