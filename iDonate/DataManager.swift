//
//  StorageManager.swift
//  iDonate
//
//  Created by Ronak Shah on 10/22/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import Foundation


class DataManager {
    static func saveArray(array: NSMutableArray, key:String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func getArray(key:String) -> NSMutableArray{
        if let data = UserDefaults.standard.object(forKey: key) as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! NSMutableArray
            return array
        }
        else {
            return NSMutableArray()
        }
    }
    static func saveObject(object: AnyObject, key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func getObject(key:String) -> AnyObject! {
        if let data = UserDefaults.standard.object(forKey: key) as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as AnyObject
            return array
        }
        else {
            return nil
        }
    }
}
