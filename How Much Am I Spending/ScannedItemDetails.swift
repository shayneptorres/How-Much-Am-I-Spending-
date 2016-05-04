//
//  ScannedItemDetails.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/2/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ScannedItemDetails: UIViewController {
    
    
    @IBOutlet weak var scannedItemDetailsDisplay: UILabel!
    
    
    var itemData = String()
    var itemModel = ScannedItemModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scannedItemDetailsDisplay.text = itemData
        itemModel.getItemData(itemData)
    }

    @IBAction func cancel(sender: UIButton) {
        performSegueWithIdentifier("canc", sender: self)
    }
    
}
