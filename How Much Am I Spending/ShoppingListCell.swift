//
//  ShoppingListCell.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 6/20/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ShoppingListCell: UITableViewCell {
    
    
    @IBOutlet weak var itemCheckedImage: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    
    var item:Item!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        itemCheckedImage.image = UIImage(named: "redCirc")
        itemNameLabel.text = "\((item.name))"
        itemQuantityLabel.text = "x\(Int((item?.quantity)!))"
        if item.checked {
            itemCheckedImage.image = UIImage(named: "greenCheckSmall")
        }
    }

}
