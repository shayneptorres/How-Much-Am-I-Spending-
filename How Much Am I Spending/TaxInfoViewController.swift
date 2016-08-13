//
//  TaxInfoViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/12/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class TaxInfoViewController: UIViewController {
    
    
    @IBAction func cancelToSettings(sender: UIButton) {
        performSegueWithIdentifier("cancelToSettingsFromTaxInfo", sender: self)
    }

}
