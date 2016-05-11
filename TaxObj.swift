//
//  TaxObj.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/8/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//
import Foundation

class TaxObj:NSObject, NSCoding {
    var stateName: String
    var taxRate: Double
    override init(){
        self.stateName = ""
        self.taxRate = 0
    }
    
    init(st: String, tr: Double){
        self.stateName = st
        self.taxRate = tr
    }
    
    required init(coder aDecoder: NSCoder){
        self.stateName = aDecoder.decodeObjectForKey("stateName") as! String
        self.taxRate = aDecoder.decodeObjectForKey("taxRate") as! Double
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(stateName, forKey: "stateName")
        aCoder.encodeObject(taxRate, forKey: "taxRate")
    }
}