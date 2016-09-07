//
//  CurrentSpendingsViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import SideMenu

class CurrentSpendingsViewController: UIViewController {
    
    
    // MARK: Outlets
    // TableViews
    @IBOutlet weak var currentSpendingsTableView: UITableView!
    
    // Buttons
    @IBOutlet weak var addItemButton: UIButton!
    
    // MARK: Variabels
    var csItems = [CurrentSpendingsItem]()
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

