//
//  OrangeFilterButton.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class OrangeFilterButton: UIButton {
    
    var isPressed = Bool()
    
    override func draw(_ rect: CGRect) {
        HMAISStyleKit.drawOrangeFilterButton(frame: rect, isPressed: isPressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isPressed = true
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isPressed = false
        setNeedsDisplay()
    }
}
