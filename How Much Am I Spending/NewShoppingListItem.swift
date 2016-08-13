//
//  NewShoppingListItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 6/20/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class NewShoppingListItem: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var itemQuantityStepper: UIStepper!
    
    @IBOutlet weak var itemQuantityDisplay: UILabel!
    
    let def = NSUserDefaults.standardUserDefaults()
    
    var items = [Item]()
    let iMod = ItemModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameTextField.delegate = self
        itemQuantityStepper.value = 1
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(NewShoppingListItem.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func updateValue(sender: UIStepper) {
        itemQuantityDisplay.text = "\(itemQuantityStepper.value)"
    }
    
    @IBAction func addItem(sender: UIButton) {
        if itemNameTextField.text == "" {
        } else {
            let newItem = Item(n: "\((itemNameTextField.text)!)", q: itemQuantityStepper.value)
            iMod.addItemToList("shoppingList", i: newItem)
            NSNotificationCenter.defaultCenter().postNotificationName("reloadShoppingList", object: nil)
        }
    }
}
