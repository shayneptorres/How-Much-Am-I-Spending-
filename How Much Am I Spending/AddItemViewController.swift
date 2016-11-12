//
//  AddItemViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/9/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

enum ItemType {
    case spendingsItem
    case customShoppingItem
}

class AddItemViewController: FormViewController {
    
    // MARK: - Models
    
    // MARK: - Variables
    var itemType = ItemType.customShoppingItem
    var itemName = String()
    var itemBrand = String()
    var notes = String()
    var price = Double()
    var listID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addForm()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Setters
    
    func setPageTitle(str: String){
        self.title = "Add \(str)"
    }
    
    // MARK: - Form Setup
    func addForm(){
        var font = UIFont.fontNames(forFamilyName: "Avenir")
        form = Section("Item Type")
            <<< AlertRow<String>("itemType"){
                $0.tag = "itemType"
                $0.title = "Choose an item type"
                $0.options = ["Spendings item", "Shoppling list item","Meal plan item"]
                $0.value = "Shopping list item"
                }
            +++ Section("Item info")
            <<< TextRow(){ row in
                row.placeholder = "name"
                row.tag = "itemName"
                
                }.onChange { [weak self] (row) in
                    if row.value != nil {
                        self?.setPageTitle(str: String(describing: row.value!))
                    } else {
                        self?.setPageTitle(str: "item")
                    }
                    
            }
            <<< DecimalRow(){
                $0.hidden = Condition.function(["itemType"], { form in
                    return !((form.rowBy(tag: "itemType") as? AlertRow)?.value == "Spendings item")
                })
                $0.placeholder = "price"
                $0.tag = "itemPrice"
            }
            <<< DateRow("date"){
                $0.hidden = Condition.function(["itemType"], { form in
                    return !((form.rowBy(tag: "itemType") as? AlertRow)?.value == "Meal plan item")
                })
                $0.title = "Meal Date"
                $0.value = NSDate() as Date
            }
            <<< TextRow(){
                $0.placeholder = "brand (optional)"
                $0.tag = "itemBrand"
            }
            <<< StepperRow(){
                $0.title = "Quantity"
                $0.tag = "itemQuantity"
                $0.value = 1.0
            }
            +++ Section("Notes")
            <<< TextAreaRow(){ row in
                row.placeholder = "Add some interesting notes about your item"
                row.tag = "notes"
            }
            +++ Section("")
            <<< ButtonRow(){ row in
                row.title = "Add Item"
                }.onCellSelection { [weak self] (cell, row) in
                    let valuesDictionary = self?.form.values()
                    //self?.listName = valuesDictionary?["listName"] as! String
                    //self?.listType = valuesDictionary?["listType"] as! String
                    //self?.notes = valuesDictionary?["notes"] as! String
                    //self?.createList()
                    
        }
    }
}
