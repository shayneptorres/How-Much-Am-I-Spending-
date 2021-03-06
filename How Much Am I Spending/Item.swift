//
//  Item.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 4/24/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding{
    var name: String
    var brand: String
    var price: Double
    var quantity: Double
    var itemNo: String
    var taxed: Bool
    var checked: Bool
    
    // Item Constructors
    override init(){
        self.name = "Item"
        self.brand = ""
        self.price = 0.0
        self.quantity = 1
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = true
        self.checked = false
    }
    
    init(n: String){
        self.name = n
        self.brand = ""
        self.price = 0.0
        self.quantity = 1
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = true
        self.checked = false
    }
    
    init(n: String, q: Double){
        self.name = n
        self.quantity = q
        self.price = 0.0
        self.brand = ""
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = false
        self.checked = false
    }
    
    init(n: String, p: Double){
        self.name = n
        self.price = p
        self.brand = ""
        self.quantity = 1
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = true
        self.checked = false
    }
    
    init (n: String, b: String, p: Double){
        self.name = n
        self.brand = b
        self.price = p
        self.quantity = 1
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = true
        self.checked = false
    }
    
    init (n: String, b: String, p: Double, q: Double, t: Bool){
        self.name = n
        self.brand = b
        self.price = p
        self.quantity = q
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
        self.taxed = t
        self.checked = false
    }
    
    // Item functions
    func setN(n: String){
        self.name = n
    }
    
    func setP(p: Double){
        self.price = p
    }
    
    func setB(b: String){
        self.brand = b
    }
    
    func generateNewItemNo(){
        self.itemNo = "\(arc4random_uniform(9999)):\(name)"
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("itemName") as! String
        self.brand = aDecoder.decodeObjectForKey("itemBrand") as! String
        self.price = aDecoder.decodeDoubleForKey("itemPrice")
        self.quantity = aDecoder.decodeDoubleForKey("itemQuantity")
        self.itemNo = aDecoder.decodeObjectForKey("itemNo") as! String
        self.taxed = aDecoder.decodeObjectForKey("taxed") as! Bool
        self.checked = aDecoder.decodeObjectForKey("checked") as! Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "itemName")
        aCoder.encodeObject(brand, forKey: "itemBrand")
        aCoder.encodeDouble(price, forKey: "itemPrice")
        aCoder.encodeDouble(quantity, forKey: "itemQuantity")
        aCoder.encodeObject(itemNo, forKey: "itemNo")
        aCoder.encodeObject(taxed, forKey: "taxed")
        aCoder.encodeObject(checked, forKey: "checked")
    }
}