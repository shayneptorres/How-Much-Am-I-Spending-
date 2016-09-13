//
//  AddSpendingsItemViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import TextFieldEffects
import SwiftyTimer

@IBDesignable
class ManageSpendingsItemViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var itemNameTextField: JiroTextField!
    @IBOutlet weak var itemPriceTextField: JiroTextField!
    @IBOutlet weak var itemBrandTextField: JiroTextField!
    @IBOutlet weak var decreaseQuantityButton: DecreaseQuantityButton!
    @IBOutlet weak var increaseQuantityButton: IncreaseQuantityButton!
    
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var saveItemButton: SaveItemButton!
    @IBOutlet weak var cancelItemButton: CancelItemButton!
    
    
    
    // Variables
    var csItem = CurrentSpendingsItem()
    var csMod = CurrentSpendingsModel()
    var mode = String()
    var ptfMod = PriceTextFieldModel()

    var itemQuantity = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemQuantityLabel.text = "1"
    }
    
    // MARK: - Button Tapped Method
    
    // Quantity Editors
    @IBAction func quantityWasChanged(sender: UIButton) {
        if sender is DecreaseQuantityButton {
            if itemQuantity == 0 {
                // Prevent further decrements
            } else {
                itemQuantity -= 1
            }
            
        } else if sender is IncreaseQuantityButton {
            itemQuantity += 1
        }
        itemQuantityLabel.text = "x\(String(itemQuantity))"
    }
    
    @IBAction func saveItemButtonWasTapped(sender: SaveItemButton) {
        if itemNameTextField.text == "" {
            view.dodo.error("Your item must have name")
            NSTimer.after(3.seconds) {
                self.view.dodo.hide()
            }
        } else {
            
        }
    }
    
    @IBAction func cancelItemButtonWasTapped(sender: CancelItemButton) {
        
    }
    
    

    @IBAction func getItemInfo(sender: UIButton) {
        let stringVal = itemPriceTextField.text!
        let doubleVal = Double(ptfMod.removeCurrencyFormatter(stringVal))
        print(doubleVal!)
        print(itemNameTextField.text!)
        print(itemBrandTextField.text!)
    }

    // MARK: Unwind Segue - Previous Menu
    func prevMenu(){
        performSegueWithIdentifier("backHome", sender: self)
    }
}
