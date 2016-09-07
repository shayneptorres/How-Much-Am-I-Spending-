//
//  AddSpendingsItemViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Eureka

class AddSpendingsItemViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Item Name")
            <<< TextRow(){ row in
                row.placeholder = "Enter Item Name Here"
            }
        form +++ Section("Item Brand")
            <<< TextRow(){ row in
                row.placeholder = "Optional Brand Here"
        }
        form +++ Section("Item Price")
            <<< DecimalRow(){ row in
                row.placeholder = "$$$"
        }
            <<< StepperRow(){ row in }
            <<< SegmentedRow(){
                $0.options = ["Taxed","Not Taxed"]
        }
        form +++ Section()
            <<< ButtonRow { row in
                row.title = "Add Item"
                }.onCellSelection{cell, row in
                    print("Will add Item")
        }
        form +++ Section()
            <<< ButtonRow { row in
                row.title = "Cancel"
                }.onCellSelection{cell, row in
                    print("Will Cancel")
        }
    }
}
