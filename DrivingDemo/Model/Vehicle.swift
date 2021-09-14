//
//  FillUpData.swift
//  DrivingDemo
//
//  Created by Vishal on 04/05/21.
//

import Foundation
import RealmSwift

class Vehicle: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var vehicleType: String = ""
    @objc dynamic var vehicleNo: String = ""
    @objc dynamic var name: String = ""
    
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    convenience init(vehicleType: String,
                     vehicleNo: String,
                     name: String) {
        self.init()
        self.vehicleType = vehicleType
        self.vehicleNo = vehicleNo
        self.name = name
    }
}

enum ExpenseType: String, CaseIterable {
    case fuel = "Fuel"
    case service = "Service"
    case other
}

class Expense: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var price: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var vehicleId: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var billImage: Data?
    @objc dynamic var serviceCenter: String = ""
    @objc dynamic var servicePerson: String = ""
    @objc private dynamic var privateType: String = ExpenseType.fuel.rawValue
    dynamic var type: ExpenseType {
        get {
            return ExpenseType(rawValue: privateType)!
        }
        set {
            privateType = newValue.rawValue
        }
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    convenience init(date: String,
                     price: String,
                     location: String,
                     type: ExpenseType,
                     detail: String,
                     vehicleId: String,
                     billImage: Data? = nil,
                     serviceCenter: String,
                     servicePerson: String) {
        self.init()
        self.date = date
        self.price = price
        self.location = location
        self.type = type
        self.detail = detail
        self.vehicleId = vehicleId
        self.billImage = billImage
        self.serviceCenter = serviceCenter
        self.servicePerson = servicePerson
    }
}






