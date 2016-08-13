//
//  ShoppingListTabBarItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 7/30/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

@IBDesignable class ShoppingListTabBarItem: UITabBarItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        image = HMAISKit.imageOfShoppingListIcon
        selectedImage = HMAISKit.imageOfShoppingListSelectedIcon
    }
}
