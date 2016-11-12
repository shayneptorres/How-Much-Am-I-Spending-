//
//  CustomShoppingListTableViewCell.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class CustomShoppingListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var colorTabView: UIView!
    
    
    var list = ShoppingList() {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        listNameLabel.text = list.name
        if list is CustomShoppingList {
            colorTabView.layer.backgroundColor = UIColor.yellow.cgColor
        }
        
        if list is MealPlan {
            colorTabView.layer.backgroundColor = UIColor.orange.cgColor
        }
        
        if list is SpendingsList {
            colorTabView.layer.backgroundColor = UIColor.blue.cgColor
        }
    }
    
}
