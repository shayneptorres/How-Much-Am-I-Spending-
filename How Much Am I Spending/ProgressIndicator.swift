//
//  ProgressIndicator.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/9/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ProgressIndicator: UIView {
    var progress = CGFloat()

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        HMAISStyleKit.drawProgressIndicator(frame: rect, progress: self.progress)
    }
}
