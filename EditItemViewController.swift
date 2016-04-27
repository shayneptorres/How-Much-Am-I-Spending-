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
    @IBOutlet weak var deleteButton: UIButton!
    var priceIsViable = false
    var alreadyFormatted = false
    var itemWasDeleted = false
    var itemPrice = Double()
    let formatter = NSNumberFormatter()
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // Boolean checknig variables
    var hasName = Bool()
    var hasPrice = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPrice = item.price
        formatter.numberStyle = .CurrencyStyle
        editItemDisplay.text = "Edit \(item.name)"
        itemNameDisplay.text = "\(item.name)"
        itemBrandDisplay.text = "\(item.brand)"
        itemPriceDiplay.text = "\(formatter.stringFromNumber(item.price)!)"
        itemStepper.value = item.quantity
        itemStepperValueDisplay.text = "\(itemStepper.value)"
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        if !hasName {
            editItem.enabled = false
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        editItem.hidden = true
        cancel.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        beginSlideAnimations()
    }
    
    // Tap gesture handeler
    func didTapView(){
        self.view.endEditing(true)
        
        
        
        
        if itemNameDisplay.text != "" {
            hasName = true
        } else {
            hasName = false
        }
        checkForValidPriceEntry()
        if itemPriceDiplay.text != "" {
            hasPrice = true
            let tempStr = itemPriceDiplay.text
            for c in (tempStr?.characters)! {
                if c == "$" {
                    alreadyFormatted = true
                }
            }
            if alreadyFormatted {
            } else {
                itemPrice = Double(itemPriceDiplay.text!)!
                itemPriceDiplay.text = "\(formatter.stringFromNumber(itemPrice)!)"
            }
        } else {
            hasPrice = false
        }
        
        if hasPrice && hasName {
            editItem.enabled = true
        } else {
            editItem.enabled = false
        }
    }
    
    @IBAction func editingDidBegin(sender: UITextField) {
            itemPriceDiplay.text = "\(itemPrice)"
    }
    
    
    @IBAction func editingDidEnd(sender: UITextField) {
        
        if itemNameDisplay.text != "" {
            hasName = true
        } else {
            hasName = false
            itemPriceDiplay.text = formatter.stringFromNumber(itemPrice)!
        }
        checkForValidPriceEntry()
        if itemPriceDiplay.text != "" {
            hasPrice = true
            let tempStr = itemPriceDiplay.text
            for c in (tempStr?.characters)! {
                if c == "$" {
                    alreadyFormatted = true
                } else {
                    alreadyFormatted = false
                }
            }
            if alreadyFormatted {
                print("this was already formatted")
            } else {
                print("formatted now")
                itemPrice = Double(itemPriceDiplay.text!)!
                itemPriceDiplay.text = "\(formatter.stringFromNumber(itemPrice)!)"
            }
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
        didTapView()
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
        let tempItem = items[index]
        let tempItemData = NSKeyedArchiver.archivedDataWithRootObject(tempItem)
        items.removeAtIndex(index)
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        defaults.setObject(currentListData, forKey: "currentTripItems")
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        performSegueWithIdentifier("backToCurrentList", sender: self)
        itemWasDeleted = true
        let deleteDefaults = NSUserDefaults.standardUserDefaults()
        deleteDefaults.setObject(tempItemData, forKey: "deletedItem")
        deleteDefaults.setBool(itemWasDeleted, forKey: "itemWasDeleted")
        
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
            checkForValidPriceEntry()
            if priceIsViable {
                editedItem.price = itemPrice
            }
        }
        editedItem.quantity = itemStepper.value
    }
    
    // MARK: -Error Checking
    func checkForValidPriceEntry(){
        var decimalCount = 0
        var postDecimaletterCount = 0
        var decimalUsed = false
        let characters = itemPriceDiplay.text
        for c in (characters?.characters)! {
            if c == "." {
                decimalCount += 1
                decimalUsed = true
            }
            if decimalUsed {
                postDecimaletterCount += 1
            }
            
        }
        if decimalCount > 1 || postDecimaletterCount > 3 {
            ShowIncorrectFormatAlert()
            itemPriceDiplay.text = ""
        } else {
            priceIsViable = true
        }
    }
    
    func ShowIncorrectFormatAlert(){
        let incorrectFormatAlert = UIAlertController(title: "Incorrect Format", message: "The price you entered in is not a viable option", preferredStyle: UIAlertControllerStyle.Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) {(action) in}
        incorrectFormatAlert.addAction(dismissAction)
        self.presentViewController(incorrectFormatAlert, animated: true, completion: nil)
    }
    
    // Signals the animations to begin
    func beginSlideAnimations(){
        editItem.center.x -= view.bounds.width
        cancel.center.x += view.bounds.width
        editItem.hidden = false
        cancel.hidden = false
        UIView.animateWithDuration(0.3, animations: { self.editItem.center.x += self.view.bounds.width })
        UIView.animateWithDuration(0.3, animations: { self.cancel.center.x -= self.view.bounds.width })
    }
}
