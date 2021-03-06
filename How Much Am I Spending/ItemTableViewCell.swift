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
    var currentTaxObj = TaxObj()
    var currentTaxAmount = Double()
    var spendMod = SpendingListModel()
    @IBOutlet weak var itemNameDisplay: UILabel!
    @IBOutlet weak var itemBrandDisplay: UILabel!
    @IBOutlet weak var itemPriceDisplay: UILabel!
    @IBOutlet weak var itemQuantityDisplay: UILabel!
    @IBOutlet weak var indiviudalItemPriceDisplay: UILabel!
    
    
    func updateUI(){
        formatter.numberStyle = .CurrencyStyle
        currentTaxAmount = spendMod.setCurrentTaxObject()
        itemNameDisplay?.text = nil
        itemBrandDisplay?.text = nil
        itemPriceDisplay?.text = nil
        itemQuantityDisplay?.text = nil
        if let item = self.item {
            if item.taxed == true {
                let itemTax = (item.price * currentTaxAmount)
                indiviudalItemPriceDisplay.text = " \(formatter.stringFromNumber(item.price)!) + tax: \(formatter.stringFromNumber(itemTax)!)  "
            } else {
                indiviudalItemPriceDisplay.text = "\(formatter.stringFromNumber(item.price)!)"
            }
            itemNameDisplay.text = item.name
            itemBrandDisplay.text = item.brand
            itemPriceDisplay.text = " \(formatter.stringFromNumber(calculateTotalItemPrice())!)  "
            itemQuantityDisplay.text = "x\(item.quantity)"
            setPriceLabelApperance()
            setTaxLabelApperance()
            setQuantityLabelAppearance()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemTableViewCell.updateUI), name: "updateUI", object: nil)
    }
    
    func calculateTotalItemPrice()->Double{
        var totItemPrice = 0.0
        if item?.taxed == true {
            totItemPrice = (item!.price + (item!.price * currentTaxAmount)) * item!.quantity
        } else {
            totItemPrice = (item!.price * item!.quantity)
        }
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
