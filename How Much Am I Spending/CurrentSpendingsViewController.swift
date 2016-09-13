//
//  CurrentSpendingsViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class CurrentSpendingsViewController: UIViewController {
    
    
    // MARK: Outlets
    // TableViews
    @IBOutlet weak var currentSpendingsTableView: UITableView!
    
    // Buttons
    @IBOutlet weak var addItemButton: UIButton!
    
    // MARK: Variabels
    var csItems = [CurrentSpendingsItem]()
    var csModel = CurrentSpendingsModel()
    var rMod = RealmModel()
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets realm file path
        rMod.setDefaultRealmForUser("shayne")
    }
    
    // MARK: View did appear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        storeCSItemsinMainArray()
    }
    
    // MARK: Database Call Functions
    // Reads from database to grab All Current Spendings Items
    func storeCSItemsinMainArray(){
        let results = csModel.readCSItems()
        csItems.removeAll()
        for i in results {
            csItems.append(i)
        }
    }


    // Unwind Segeues
    @IBAction func backToHome(segue: UIStoryboardSegue){}
}

