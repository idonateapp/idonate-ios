//
//  Address.swift
//  iDonate
//
//  Created by Ronak Shah on 10/22/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import Foundation

class Address: NSObject, NSCoding {
    let name: String
    let addressLine1: String
    let addressLine2: String
    let state: String
    let city: String
    let country: String
    let zip: String
    let number: String
    
    required init(name: String, a1: String, a2: String, state: String, city: String, country: String, zip: String, number: String) {
        self.name = name
        self.addressLine1 = a1
        self.addressLine2 = a2
        self.state = state
        self.city = city
        self.country = country
        self.zip = zip
        self.number = number
        super.init()
    }
    //MARK: - NSCoding -
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.addressLine1 = aDecoder.decodeObject(forKey: "a1") as! String
        self.addressLine2 = aDecoder.decodeObject(forKey: "a2") as! String
        self.state = aDecoder.decodeObject(forKey: "state") as! String
        self.city = aDecoder.decodeObject(forKey: "city") as! String
        self.country = aDecoder.decodeObject(forKey: "country") as! String
        self.zip = aDecoder.decodeObject(forKey: "zip") as! String
        self.number = aDecoder.decodeObject(forKey: "number") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(addressLine1, forKey: "a1")
        aCoder.encode(addressLine2, forKey: "a2")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(zip, forKey: "zip")
        aCoder.encode(number, forKey: "number")
    }
    
}

class Product: NSObject, NSCoding {
    let name: String
    let barcode: String
    
    required init(name: String, barcode: String) {
        self.name = name
        self.barcode = barcode
        super.init()
    }
    //MARK: - NSCoding -
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.barcode = aDecoder.decodeObject(forKey: "barcode") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(barcode, forKey: "barcode")
    }
}

class Charity: NSObject, NSCoding {
    let address:Address
    
    required init(address: Address) {
        self.address = address
    }
    
    required init(coder aDecoder: NSCoder) {
        self.address = aDecoder.decodeObject(forKey: "address") as! Address
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(address, forKey: "address")
    }
}

class Country: NSObject, NSCoding {
    let name: String
    let id: String
    
    required init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    func equals(other: Country) -> Bool {
        if (self.name == other.name || self.id == other.id) {
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: - NSCoding -
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
    }
}
