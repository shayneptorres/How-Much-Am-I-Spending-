//
//  SpendingListModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class SpendingListModel{
    class TotalPriceReturn{
        var price = Double()
        var title = String()

        init(p: Double, t: String){
            self.price = p
            self.title = t
        } // init
    } // subclass
    
    class ChangedItemReturnObject{
        var hex = Int()
        var alpha = Float()
        var bounds = Bool()
        var cornRad = Int()
        var text = String()
        
        init(){}
        
        init(h: Int,t: String){
            self.hex = h
            self.alpha = 0.85
            self.bounds = true
            self.cornRad = 5
            self.text = t
        }
    } // Subclass
    
    let CA_SALES_TAX = 0.08
    var def = NSUserDefaults.standardUserDefaults()
    var itemThatWasChanged = Item()
    var itemWasChanged = String()
    var currentTaxObject = TaxObj()
    var currentTaxAmount = Double()
    
    func setTotalPrice(items: [Item], mode: String)->TotalPriceReturn{
        var totPrice = Double()
        setCurrentTaxObject()
        if mode == "freeMode" {
            if items.isEmpty{
                let returnObj = TotalPriceReturn(p: 0.0, t: "Total Spendings:")
                return returnObj
            } else {
                for i in items{
                    if i.taxed == true {
                        totPrice += ((i.price + (i.price * currentTaxAmount)) * i.quantity)
                    } else {
                        totPrice += ((i.price * i.quantity))
                    }
                }// if is not empty
                let returnObj = TotalPriceReturn(p: totPrice, t: "Total Spendings:")
                return returnObj
            } // if is empty
        } // if freeMode
        else {
            let budget = def.doubleForKey("budget")
//            print(budget)
            if items.isEmpty {
                let returnObj = TotalPriceReturn(p: budget, t: "Money Remaining:")
                return returnObj
            }// if is empty
            else {
                var monLeft = budget
                for i in items{
                    if i.taxed == true {
                        monLeft -= ((i.price + (i.price * currentTaxAmount)) * i.quantity)
                    } else {
                        monLeft -= ((i.price * i.quantity))
                    }
//                 monLeft -= ((i.price + (i.price * currentTaxAmount)) * i.quantity)
                }
                let returnObj = TotalPriceReturn(p: monLeft, t: "Money Remaining:")
                return returnObj
            }// if is not empty
        } // if budgetMode
    } // setTotalPrice
    
    func setCurrentTaxObject()->Double{
        if def.objectForKey("currentTaxObj") != nil {
            let tempData = def.objectForKey("currentTaxObj") as! NSData
            let decodedData = NSKeyedUnarchiver.unarchiveObjectWithData(tempData) as! TaxObj
            currentTaxObject = decodedData
            currentTaxAmount = currentTaxObject.taxRate
            return currentTaxAmount
        } else {
            currentTaxAmount = CA_SALES_TAX
            return currentTaxAmount
        }
    }
    
    func setChangedItemAppearance(change: String, itemThatChanged: String)->ChangedItemReturnObject{
        var retObj = ChangedItemReturnObject()
        switch change {
        case "deleted":
            let itemChanged = ChangedItemReturnObject(h:0xFB3125, t: "'\(itemThatChanged)' was deleted")
            retObj = itemChanged
            break
        case "added":
            let itemChanged = ChangedItemReturnObject(h:0x25FB79, t: "'\(itemThatChanged)' was added")
            retObj = itemChanged
            break
        case "edited":
            let itemChanged = ChangedItemReturnObject(h:0xF59D0C, t: "'\(itemThatChanged)' was edited")
            retObj = itemChanged
            break
        default: break
        } // switch
        return retObj
    } //  setChanged
    
} // class