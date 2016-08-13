//
//  SettingsTabBarItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 7/31/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class SettingsTabBarItem: UITabBarItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        image = HMAISKit.imageOfSettingsIcon
        selectedImage = HMAISKit.imageOfSettingsSelectedIcon
    }
}
