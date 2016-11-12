//
//  ShoppingListItemCell.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/9/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ShoppingListItemCell: UITableViewCell {
    
    var item = ShoppingListItem(){
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    func updateUI(){
        itemNameLabel.text = item.name
    }
}
