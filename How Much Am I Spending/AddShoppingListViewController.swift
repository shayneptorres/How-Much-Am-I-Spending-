//
//  AddShoppingListViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/5/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Eureka

class AddShoppingListViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showAddShoppingListForm()
        // Do any additional setup after loading the view.
    }
    
    func showAddShoppingListForm(){
        form = Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = NSDate(timeIntervalSinceReferenceDate: 0) as Date
        }
    }
}
