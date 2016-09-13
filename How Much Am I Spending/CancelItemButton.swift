//
//  CancelItemButton.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/13/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class CancelItemButton: UIButton {
    override func drawRect(rect: CGRect) {
        self.setBackgroundImage(ManageItemsStyleKit.imageOfCancelButton(frame: rect), forState: UIControlState.Normal)
        self.setNeedsDisplay()
    }
}
