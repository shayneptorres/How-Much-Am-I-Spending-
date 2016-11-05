//
//  WelcomeVCTextField.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class WelcomeVCTextField: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderWidth = 1.0
        attributedPlaceholder = NSAttributedString(string:"Name",
        attributes:[NSForegroundColorAttributeName: UIColor.white])
    }

    // Placeholder modifiers
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    // Text modifiers
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
