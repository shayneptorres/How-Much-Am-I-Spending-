//
//  CurrentSpendingsTabBarItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 7/30/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class CurrentSpendingsTabBarItem: UITabBarItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        image = HMAISKit.imageOfCurrentSpendingsTabBarIcon
        selectedImage = HMAISKit.imageOfCurrentSpendingsSelectedIcon
    }
}
