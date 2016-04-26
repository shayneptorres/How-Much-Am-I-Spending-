//
//  EditItemViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 4/25/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {
    // Item Instances
    var item = Item()
    var items = [Item]()
    let editedItem = Item()
    
    // Outlet variables
    @IBOutlet weak var editItemDisplay: UILabel!
    @IBOutlet weak var itemNameDisplay: UITextField!
    @IBOutlet weak var itemBrandDisplay: UITextField!
    @IBOutlet weak var itemPriceDiplay: UITextField!
    @IBOutlet weak var editItem: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var itemStepper: UIStepper!
    @IBOutlet weak var itemStepperValueDisplay: UILabel!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // Boolean checknig variables
    var hasName = Bool()
    var hasPrice = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editItemDisplay.text = "Edit \(item.name)"
        itemNameDisplay.text = "\(item.name)"
        itemBrandDisplay.text = "\(item.brand)"
        itemPriceDiplay.text = "\(item.price)"
        itemStepper.value = item.quantity
        itemStepperValueDisplay.text = "\(itemStepper.value)"
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        if !hasName {
            editItem.enabled = false
        }
    }
    
    // Tap gesture handeler
    func didTapView(){
        self.view.endEditing(true)
        if itemNameDisplay.text != "" {
            hasName = true
        } else {
            hasName = false
        }
        
        if itemPriceDiplay.text != "" {
            hasPrice = true
        } else {
            hasPrice = false
        }
        
        if hasPrice && hasName {
            editItem.enabled = true
        } else {
            editItem.enabled = false
        }
    }
    
    
    @IBAction func incrementStepper(sender: UIStepper) {
        itemStepperValueDisplay.text = "\(itemStepper.value)"
    }
    
    // MARK: - Unwind Segue
    @IBAction func cancel(sender: UIButton) {
        performSegueWithIdentifier("cancel", sender: self)
    }
    
    // MARK: - Edit the item and save it to the current list
    @IBAction func editItem(sender: UIButton) {
//        let editedItem = Item()
        if defaults.objectForKey("currentTripItems") != nil {
            // If there is a current trip list, add this item to it
            let itemsList = defaults.objectForKey("currentTripItems") as! NSData
            let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
            self.items = encodedCurrentItemsData!
        } else {
            // If there is no current list, just go back to previous screen
            // NEED TO FIX
            performSegueWithIdentifier("backToCurrentList", sender: self)
        }
        var index = Int()
        for i in items {
            if i.itemNo == self.item.itemNo {
                index = items.indexOf(i)!
            }
        }
        updateItem()
        items.removeAtIndex(index)
        items.insert(self.item, atIndex: index)
        items[index] = editedItem
        self.item.generateNewItemNo()
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        defaults.setObject(currentListData, forKey: "currentTripItems")
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        performSegueWithIdentifier("backToCurrentList", sender: self)
    }

    @IBAction func deleteItem(sender: UIButton) {
        let itemsList = defaults.objectForKey("currentTripItems") as! NSData
        let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
        self.items = encodedCurrentItemsData!
        var index = Int()
        for i in items {
            if i.name == self.item.name {
                index = items.indexOf(i)!
            }
        }
        items.removeAtIndex(index)
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        defaults.setObject(currentListData, forKey: "currentTripItems")
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        performSegueWithIdentifier("backToCurrentList", sender: self)
    }
    
    // Set the edited items values
    func updateItem(){
        if itemNameDisplay.text == "" {
            editedItem.name = "Unnamed Item"
        } else {
            editedItem.name = itemNameDisplay.text!
        }
        
        if itemBrandDisplay.text == "" {
            itemBrandDisplay.text = ""
        } else {
            editedItem.brand = itemBrandDisplay.text!
        }
        
        if itemPriceDiplay.text == "" {
            itemPriceDiplay.text = "0"
        } else {
            editedItem.price = Double(itemPriceDiplay.text!)!
        }
        editedItem.quantity = itemStepper.value
    }
}
