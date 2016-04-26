//
//  NewItemEntryViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 4/25/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class NewItemEntryViewController: UIViewController {
    
    // Outlet Variables
    @IBOutlet weak var itemNameEntry: UITextField!
    @IBOutlet weak var itemBrandEntry: UITextField!
    @IBOutlet weak var itemPriceEntry: UITextField!
    @IBOutlet weak var quantityDisplay: UILabel!
    @IBOutlet weak var itemQuanityStepper: UIStepper!
    @IBOutlet weak var itemQuanityDisplay: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    
    var hasName = false
    var hasPrice = false
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemQuanityStepper.value = 1
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        if !hasName {
            addItemButton.enabled = false
        }
    }
    
    // Function for tap gesture
    func didTapView(){
        self.view.endEditing(true)
        if itemNameEntry.text != "" {
            hasName = true
        } else {
            hasName = false
        }
        
        if itemPriceEntry.text != "" {
            hasPrice = true
        } else {
            hasPrice = false
        }
        
        if hasPrice && hasName {
            addItemButton.enabled = true
        } else {
            addItemButton.enabled = false
        }
    }
    
    // Increments stepper value
    @IBAction func incrementStepper(sender: UIStepper) {
        itemQuanityDisplay.text = "\(itemQuanityStepper.value)"
    }
    
    // Adds the new item to the current list
    @IBAction func addItem(sender: UIButton) {
        let newItem = Item()
        if itemNameEntry.text == "" {
            newItem.name = "Unnamed Item"
        } else {
            newItem.name = itemNameEntry.text!
        }
        
        if itemBrandEntry.text == "" {
            itemBrandEntry.text = "Unnamed Brand"
        } else {
            newItem.brand = itemBrandEntry.text!
        }
        
        if itemPriceEntry.text == "" {
            itemBrandEntry.text = "0"
        } else {
            newItem.price = Double(itemPriceEntry.text!)!
        }
        
        newItem.quantity = itemQuanityStepper.value
        
        if defaults.objectForKey("currentTripItems") != nil {
        // If there is a current trip list, add this item to it
            let itemsList = defaults.objectForKey("currentTripItems") as! NSData
            let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
            self.items = encodedCurrentItemsData!
            print("current Items list found")
        }
        items.insert(newItem, atIndex: 0)
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        defaults.setObject(currentListData, forKey: "currentTripItems")
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        performSegueWithIdentifier("backToCurrentList", sender: self)
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegueWithIdentifier("cancel", sender: self)
    }
}
