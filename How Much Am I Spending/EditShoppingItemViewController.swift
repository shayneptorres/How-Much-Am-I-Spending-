//
//  EditShoppingItemViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 6/21/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class EditShoppingItemViewController: UIViewController {
//    "shoppingList", tl: "currentTripItems" 

    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var itemBrandTextField: UITextField!
    
    @IBOutlet weak var itemPriceTextField: UITextField!
    
    @IBOutlet weak var editItemButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var deleteItemButton: UIButton!
    
    @IBOutlet weak var itemQuantityDisplay: UILabel!
    
    @IBOutlet weak var itemQuantityStepper: UIStepper!
    
    @IBOutlet weak var itemTaxedControl: UISegmentedControl!
    
    let iMod = ItemModel()
    let formatter = NSNumberFormatter()
    var item = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .CurrencyStyle
        setDisplay()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(EditShoppingItemViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func didTapView(){
        self.view.endEditing(true)
        if itemPriceTextField.text == "" {
            itemPriceTextField.text = "$0.00"
        } else if itemPriceTextField.text == "$0.00" {
            
        } else {
            if Double(itemPriceTextField.text!) != nil {
                item.price = Double(itemPriceTextField.text!)!
            }
            
            itemPriceTextField.text = "\(formatter.stringFromNumber(item.price)!)"
        }
    }
    
    @IBAction func editingDidBegin(sender: UITextField) {
        itemPriceTextField.text = ""
    }
    
    @IBAction func changeQuantity(sender: UIStepper) {
        itemQuantityDisplay.text = "\(itemQuantityStepper.value)"
        item.quantity = itemQuantityStepper.value
    }
    
    
    
    @IBAction func editItem(sender: UIButton) {
        if itemPriceTextField.text == "$0.00" {
            
        } else {
            if itemTaxedControl.selectedSegmentIndex == 0 {
                item.taxed = true
            }
            iMod.editItemToList("shoppingList", tl: "currentTripItems", i: item, n: item.name, b: item.brand, p: item.price, q: item.quantity, t: item.taxed, c: true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("reloadShoppingList", object: nil)
        }

    }
    
    
    @IBAction func deleteItem(sender: UIButton) {
        iMod.deleteItemFromList("shoppingList", i: item)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadShoppingList", object: nil)
    }
    
    func setItemValues(){
        
    }
    
    func setDisplay(){
        itemNameTextField.text = item.name
        itemPriceTextField.text = "\(formatter.stringFromNumber(0.0)!)"
//        itemPriceTextField.text = "\(item.price)"
        itemQuantityDisplay.text = "\(item.quantity)"
        itemQuantityStepper.value = item.quantity
        if item.taxed {
            itemTaxedControl.selectedSegmentIndex = 0
        } else {
            itemTaxedControl.selectedSegmentIndex = 1
        }
        
    }
    
    
    
    
}
