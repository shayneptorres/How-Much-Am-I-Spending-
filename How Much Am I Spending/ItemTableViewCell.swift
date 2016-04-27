//
//  ItemTableViewCell.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 4/24/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    var item: Item?{
        didSet{
            updateUI()
        }
    }
    let formatter = NSNumberFormatter()
    let CA_SALES_TAX = 0.0725
    
    @IBOutlet weak var itemNameDisplay: UILabel!
    
    @IBOutlet weak var itemBrandDisplay: UILabel!
    
    @IBOutlet weak var itemPriceDisplay: UILabel!
    
    @IBOutlet weak var itemQuantityDisplay: UILabel!
    
    @IBOutlet weak var itemTaxDisplay: UILabel!
    
    
    func updateUI(){
        formatter.numberStyle = .CurrencyStyle
        itemNameDisplay?.text = nil
        itemBrandDisplay?.text = nil
        itemPriceDisplay?.text = nil
        itemQuantityDisplay?.text = nil
        if let item = self.item{
            let itemTax = (item.price * CA_SALES_TAX)
            itemTaxDisplay.text = "tax: \(formatter.stringFromNumber(itemTax)!)"
            itemNameDisplay.text = item.name
            itemBrandDisplay.text = item.brand
            itemPriceDisplay.text = "\(formatter.stringFromNumber(item.price)!)"
            itemQuantityDisplay.text = "x\(item.quantity)"
            setPriceLabelApperance()
            setTaxLabelApperance()
            setQuantityLabelAppearance()
        }
    }
    
    func setPriceLabelApperance(){
        itemPriceDisplay.backgroundColor = UIColor(netHex: 0x18E42E)
        itemPriceDisplay.layer.masksToBounds = true
        itemPriceDisplay.layer.cornerRadius = 6
    }
    
    func setTaxLabelApperance(){
        itemTaxDisplay.layer.masksToBounds = true
        itemTaxDisplay.layer.cornerRadius = 6
    }
    
    func setQuantityLabelAppearance(){
//        itemQuantityDisplay.backgroundColor = UIColor(netHex: 0xA83EFC)
        itemQuantityDisplay.layer.masksToBounds = true
        itemQuantityDisplay.layer.cornerRadius = 6
    }
}
