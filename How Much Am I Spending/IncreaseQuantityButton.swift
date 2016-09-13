//
//  IncreaseQuantityButton.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/11/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

@IBDesignable class IncreaseQuantityButton: UIButton {
   override func drawRect(rect: CGRect) {
        self.setBackgroundImage(ManageItemsStyleKit.imageOfIncreaseQuantityButton(frame: rect), forState: UIControlState.Normal)
        self.setNeedsDisplay()
    }

}
