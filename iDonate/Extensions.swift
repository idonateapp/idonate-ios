//
//  Extensions.swift
//  iDonate
//
//  Created by Ronak Shah on 10/31/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import Foundation

import UIKit

private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
                          /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
                                                /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
                                                                      /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
                                                                                            /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
                                                                                                                  /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
                                                                                                                                        /* iPhone 6 */        "iPhone7,2": "iPhone 6",
                                                                                                                                                              /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
                                                                                                                                                                                    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
                                                                                                                                                                                                          /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
                                                                                                                                                                                                                                /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
                                                                                                                                                                                                                                                      /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
                                                                                                                                                                                                                                                                            /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
                                                                                                                                                                                                                                                                                                  /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
                                                                                                                                                                                                                                                                                                                        /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
                                                                                                                                                                                                                                                                                                                                              /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
                                                                                                                                                                                                                                                                                                                                                                    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        //let mirror = select(machine)                // Swift 1.2
        let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        // Swift 1.2 - if you use Swift 2.0 comment this loop out.
        /*for i in 0..<mirror.count {
            if let value = mirror[i].1.value as? Int8, value != 0 {
                identifier.append(UnicodeScalar(UInt8(value)))
            }
        }*/
        
         //Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
         for child in mirror.children where child.value as? Int8 != 0 {
            //identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
            //identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
            let scalar = UnicodeScalar(UInt8(child.value as! Int8))
            let char = Character(scalar)
            identifier.append(char)
         }
        
        return DeviceList[identifier] ?? identifier
    }
}
extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
