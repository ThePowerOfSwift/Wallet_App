//
//  DB_PathFind.swift
//  wallet
//
//  Created by Ammy Pandey on 22/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class DB_PathFind: NSObject {
    
    //Find the Absolute Path Of Device Document Directory
    
    
    class func getPath(filename: String) -> String{
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = docUrl.appendingPathComponent(filename)
        return fileUrl.path
    }
    //Copy the sqlite db file to document directory for modifie like delete save update and fetch
    
    class func copyDb(filename: String){
        let dbPath: String = getPath(filename: filename)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath){
            let docUrl = Bundle.main.resourceURL
            let fromPath = docUrl!.appendingPathComponent(filename)
            var error: NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            }catch let err as NSError{
                error = err
            }
            if error != nil {
                print("Db file not copy")
            }else{
                print("Db copy")
            }
        }
    }
}
