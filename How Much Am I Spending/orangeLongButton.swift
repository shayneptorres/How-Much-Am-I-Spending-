//
//  orangeLongButton.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class orangeLongButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 8.0
        layer.backgroundColor = UIColor.init(red: 1.0, green: 0.517, blue: 0.117, alpha: 1.0).cgColor
        layer.borderWidth = 0.0
        layer.masksToBounds = true
    }
}
