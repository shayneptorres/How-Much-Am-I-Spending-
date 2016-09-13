//
//  PriceTextFieldModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/10/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects 

class PriceTextFieldModel{
    var price = Int()
    var vals = [String]()
    var textField = JiroTextField()
    
    init(){
    }

    func removeCurrencyFormatter(str: String)->String{
        var newString = str.stringByReplacingOccurrencesOfString("$", withString: "")
        newString = newString.stringByReplacingOccurrencesOfString(",", withString: "")
        return newString
    }
}