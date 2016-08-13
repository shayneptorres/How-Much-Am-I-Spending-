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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var taxedOrNotControl: UISegmentedControl!
    
    
    var hasName = false
    var hasPrice = false
    var alreadyFormatted = false
    var priceIsViable = false
    let formatter = NSNumberFormatter()
    var itemPrice = Double()
    var itemMod = ItemModel()
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var items = [Item]()
    let newItem = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addItemButton.hidden = true
        cancelButton.hidden = true
        itemQuanityStepper.value = 1
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(NewItemEntryViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        if !hasName {
            addItemButton.enabled = false
        }
        formatter.numberStyle = .CurrencyStyle
    }
    
    override func viewDidAppear(animated: Bool) {
        beginSlideAnimations()
    }
    
    @IBAction func editingDidBegin(sender: UITextField) {
        if hasPrice {
            itemPriceEntry.text = ("\(itemPrice)")
        }
    }
    
    @IBAction func editingDidEnd(sender: UITextField) {
        if itemNameEntry.text != "" {
            hasName = true
        } else {
            hasName = false
        }
        checkForValidPriceEntry()
        if itemPriceEntry.text != "" {
            hasPrice = true
            let tempStr = itemPriceEntry.text
            for c in (tempStr?.characters)! {
                if c == "$" {
                    alreadyFormatted = true
                }
            }
            if alreadyFormatted {
            } else {
                itemPrice = Double(itemPriceEntry.text!)!
                itemPriceEntry.text = "\(formatter.stringFromNumber(itemPrice)!)"
            }
        } else {
            hasPrice = false
        }
        
        if hasPrice && hasName {
            addItemButton.enabled = true
        } else {
            addItemButton.enabled = false
        }
    }
    
    
    // Function for tap gesture
    func didTapView(){
        self.view.endEditing(true)
    }
    
    // Increments stepper value
    @IBAction func incrementStepper(sender: UIStepper) {
        itemQuanityDisplay.text = "\(itemQuanityStepper.value)"
    }
    
    // Adds the new item to the current list
    @IBAction func addItem(sender: UIButton) {

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
        if priceIsViable == false {
            checkForValidPriceEntry()
        }
        if itemPriceEntry.text == "" {
            itemBrandEntry.text = "0"
        } else {
            if priceIsViable {
                
                newItem.price = itemPrice
                newItem.quantity = itemQuanityStepper.value
                // Try to insert Item Model Here
                if defaults.objectForKey("currentTripItems") != nil {
                        // If there is a current trip list, add this item to it
                    let itemsList = defaults.objectForKey("currentTripItems") as! NSData
                    let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
                    self.items = encodedCurrentItemsData!
                    print("current Items list found")
                }
                
                items.insert(newItem, atIndex: 0)
                let tempItemData = NSKeyedArchiver.archivedDataWithRootObject(newItem)
                defaults.setValue(tempItemData, forKey: "itemThatWasChanged")
                let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
                defaults.setObject(currentListData, forKey: "currentTripItems")
                NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
                //
                let itemWasChanged = "added"
                defaults.setValue(itemWasChanged, forKey: "itemWasChanged")
                performSegueWithIdentifier("backToCurrentList", sender: self)
            }
        }
    }
    
    
    @IBAction func setTaxedValue(sender: UISegmentedControl) {
        if taxedOrNotControl.selectedSegmentIndex == 0 {
            newItem.taxed = true
        } else if taxedOrNotControl.selectedSegmentIndex == 1 {
            newItem.taxed = false
        } else if taxedOrNotControl.selectedSegmentIndex == 2 {
//        defaults.setValue("adding", forKey: 
//        let notSureAlert = UIAlertController(title: "Not Sure?", message: "Not sure what is taxed or what isn't?", preferredStyle: UIAlertControllerStyle.Alert)
//        let dissmissAction = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default) { (action) in}
//            notSureAlert.addAction(dissmissAction)
//            // Add the alert functions here
//        self.presentViewController(notSureAlert, animated: true, completion: nil)
        }
    }
    
    
    func checkForValidPriceEntry(){
        var decimalCount = 0
        var postDecimaletterCount = 0
        var decimalUsed = false
        let characters = itemPriceEntry.text
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
            itemPriceEntry.text = "0.00"
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
    
    @IBAction func cancel(sender: UIButton) {
        defaults.setValue("", forKey: "itemWasChanged")
        performSegueWithIdentifier("cancel", sender: self)
    }
    
    func beginSlideAnimations(){
        addItemButton.center.x -= view.bounds.width
        cancelButton.center.x += view.bounds.width
        addItemButton.hidden = false
        cancelButton.hidden = false
        UIView.animateWithDuration(0.3, animations: {self.addItemButton.center.x += self.view.bounds.width})
        UIView.animateWithDuration(0.3, animations: {self.cancelButton.center.x -= self.view.bounds.width})
    }
}
