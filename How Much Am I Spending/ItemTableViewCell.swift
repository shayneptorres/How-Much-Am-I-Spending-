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
    
    @IBOutlet weak var itemNameDisplay: UILabel!
    
    @IBOutlet weak var itemBrandDisplay: UILabel!
    
    @IBOutlet weak var itemPriceDisplay: UILabel!
    
    @IBOutlet weak var itemQuantityDislay: UILabel!
    
    func updateUI(){
        formatter.numberStyle = .CurrencyStyle
        itemNameDisplay?.text = nil
        itemBrandDisplay?.text = nil
        itemPriceDisplay?.text = nil
        itemQuantityDislay?.text = nil
        if let item = self.item{
            itemNameDisplay.text = item.name
            itemBrandDisplay.text = item.brand
            itemPriceDisplay.text = "\(formatter.stringFromNumber(item.price)!)"
            itemQuantityDislay.text = "x\(item.quantity)"
            setPriceLabelApperance()
            
        }
    }
    
    func setPriceLabelApperance(){
        itemPriceDisplay.backgroundColor = UIColor(netHex: 0x18E42E)
        itemPriceDisplay.layer.masksToBounds = true
        itemPriceDisplay.layer.cornerRadius = 6
    }
}
