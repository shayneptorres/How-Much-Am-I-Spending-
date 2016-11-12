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
    
    // MARK: - Models
    let slMod = ShoppingListModel()
    
    // MARK: - Variables
    var listName = String()
    var listType = String()
    var notes = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        showAddShoppingListForm()
    }
    
    func showAddShoppingListForm(){
        form = Section("List Name")
            <<< TextRow(){ row in
                row.placeholder = "Super Cool List Name"
                row.tag = "listName"
            }
            +++ Section("List Type")
            <<< SegmentedRow<String>(){
                $0.options = ["Shopping List","Meal Plan","Spendings List"]
                $0.tag = "listType"
            }
            +++ Section("Notes")
            <<< TextAreaRow(){ row in
                row.placeholder = "Add some interesting notes about your list"
                row.tag = "notes"
            }
            +++ Section("")
            <<< ButtonRow(){ row in
                row.title = "Add List"
                }.onCellSelection { [weak self] (cell, row) in
                    let valuesDictionary = self?.form.values()
                    self?.listName = valuesDictionary?["listName"] as! String
                    self?.listType = valuesDictionary?["listType"] as! String
                    self?.notes = valuesDictionary?["notes"] as! String
                    self?.createList()
                    
            }
    }
    
    // MARK: - List Creation Method
    func createList(){
        switch listType {
        case "Shopping List":
            let newShoppingList = CustomShoppingList()
            newShoppingList.name = self.listName
            newShoppingList.notes = self.notes
            print(newShoppingList.notes)
            slMod.addCustomShoppingList(list: newShoppingList)
            print("Created a new shoppingList")
            break
        case "Meal Plan":
            let newMealPlan = MealPlan()
            newMealPlan.name = self.listName
            newMealPlan.notes = self.notes
            slMod.addMealPlan(mp: newMealPlan)
            print("Created a new MealPlnan")
            break
        case "Spendings List":
            let newCurrentspendingsList = SpendingsList()
            newCurrentspendingsList.name = self.listName
            newCurrentspendingsList.notes = self.notes
            slMod.addCurrentSpendingsList(sl: newCurrentspendingsList)
            print(newCurrentspendingsList)
            break
        default:
            break
        }
        performSegue(withIdentifier: "unwindBackToHomeVC", sender: self)
    }
    
}

