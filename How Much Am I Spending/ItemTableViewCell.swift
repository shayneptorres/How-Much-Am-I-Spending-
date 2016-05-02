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
    let CA_SALES_TAX = 0.075
    @IBOutlet weak var itemNameDisplay: UILabel!
    @IBOutlet weak var itemBrandDisplay: UILabel!
    @IBOutlet weak var itemPriceDisplay: UILabel!
    @IBOutlet weak var itemQuantityDisplay: UILabel!
    @IBOutlet weak var indiviudalItemPriceDisplay: UILabel!
    
    
    func updateUI(){
        formatter.numberStyle = .CurrencyStyle
        itemNameDisplay?.text = nil
        itemBrandDisplay?.text = nil
        itemPriceDisplay?.text = nil
        itemQuantityDisplay?.text = nil
        if let item = self.item{
            let itemTax = (item.price * CA_SALES_TAX)
            indiviudalItemPriceDisplay.text = "\(formatter.stringFromNumber(item.price)!) + tax: \(formatter.stringFromNumber(itemTax)!)"
            itemNameDisplay.text = item.name
            itemBrandDisplay.text = item.brand
            itemPriceDisplay.text = "\(formatter.stringFromNumber(calculateTotalItemPrice())!)"
            itemQuantityDisplay.text = "x\(item.quantity)"
            setPriceLabelApperance()
            setTaxLabelApperance()
            setQuantityLabelAppearance()
        }
    }
    
    func calculateTotalItemPrice()->Double{
        let totItemPrice = (item!.price + (item!.price * CA_SALES_TAX)) * item!.quantity
        return totItemPrice
    }
    
    func setPriceLabelApperance(){
        itemPriceDisplay.backgroundColor = UIColor(netHex: 0x18E42E)
        itemPriceDisplay.layer.masksToBounds = true
        itemPriceDisplay.layer.cornerRadius = 6
    }
    
    
    func setTaxLabelApperance(){
       indiviudalItemPriceDisplay.layer.masksToBounds = true
        indiviudalItemPriceDisplay.layer.cornerRadius = 6
    }
    
    func setQuantityLabelAppearance(){
        itemQuantityDisplay.layer.masksToBounds = true
        itemQuantityDisplay.layer.cornerRadius = 6
    }
}
