//
//  SettingsViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 4/27/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    // MARK: - Outlet Variables
    @IBOutlet weak var freeSpendButton: UIButton!
    @IBOutlet weak var budgetModeButton: UIButton!
    @IBOutlet weak var setBudgetButton: UIButton!
    @IBOutlet weak var enterBudgetLabel: UILabel!
    @IBOutlet weak var enterBudgetTextField: UITextField!
    @IBOutlet weak var selectStateButton: UIButton!
    
    
    
    // MARK: - Special Variables
    var defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    let tax = StateTax()
    
    // Variables
    var freeMode = false
    var budgetMode = false
    var hasSetBudget = false
    var budgetIsViable = false
    var setBudget = 0.0
    var alreadyFormatted = false
    var labelsHaveAnimated = false
    var mode = String()
    var state = String()
    var pickerDataSource = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        freeMode = false
        budgetMode = false
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(SettingsViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        formatter.numberStyle = .CurrencyStyle
    }
    
    
    override func viewDidAppear(animated: Bool) {
        freeSpendButton.hidden = false
        budgetModeButton.hidden = false
        setBudgetButton.hidden = true
        enterBudgetLabel.center.x -= view.bounds.width
        enterBudgetTextField.center.x += view.bounds.width
        setBudgetButton.center.y += 200
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        defaults.setValue(state, forKey: "state")
    }
    
    // MARK: - Button Handelers
    @IBAction func selectFreeSpendMode(sender: UIButton) {
        let selectedFreeSpendAlert = UIAlertController(title: "Free Spend Mode", message: "In Free Spend mode,  you are not bound to a specific budget and all your item prices will be added to a total that will be displayed at the top of the screen. Is this what you would like?", preferredStyle: UIAlertControllerStyle.Alert)
        let comfirmAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {(action) in self.freeMode = true;self.budgetMode = false; self.setMode()}
        let dissmissAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {(action) in}
        selectedFreeSpendAlert.addAction(dissmissAction)
        selectedFreeSpendAlert.addAction(comfirmAction)
        self.presentViewController(selectedFreeSpendAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func selectBudgetMode(sender: UIButton) {
        let selectedBudgetAlert = UIAlertController(title: "Budget Mode", message: "In Budget Mode, you set a specific amount of money you want to spend. This app will keep track of how much money you have left to spend and will give warnings and alerts if you are close to or go over your set budget. Is this what you would like?", preferredStyle: UIAlertControllerStyle.Alert)
        let comfirmAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {(action) in self.budgetMode = true;self.freeMode = false; self.slideInBudgetSetterLabel();self.slideOutModeSetters(); self.setBudget = 0}
        let dissmissAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {(action) in}
        selectedBudgetAlert.addAction(dissmissAction)
        selectedBudgetAlert.addAction(comfirmAction)
        self.presentViewController(selectedBudgetAlert, animated: true, completion: nil)
    }
    
    @IBAction func setBudget(sender: UIButton) {
        if hasSetBudget {
            defaults.setDouble(setBudget, forKey: "budget")
            print(setBudget)
            print("While setting budget, Mode is:\(mode)")
            setMode()
        } else {
        
        }
    }
    
    func setMode(){
        if freeMode {
            mode = "freeMode"
        } else {
            mode = "budgetMode"
        }
        defaults.setValue(mode, forKey: "mode")
        print("Mode is: \(mode)")
        performSegueWithIdentifier("backToCurrentSpendings", sender: self)
    }
    
    
    // MARK: - Alerts
    func showIncorrectFormatAlert(){
        let incorrectFormatAlert = UIAlertController(title: "Incorrect Format", message: "The value you entered in is not a viable option.", preferredStyle: UIAlertControllerStyle.Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) {(action) in}
        incorrectFormatAlert.addAction(dismissAction)
        self.presentViewController(incorrectFormatAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - Animations
    func slideInBudgetSetterLabel(){
        enterBudgetTextField.hidden = false
        enterBudgetLabel.hidden = false
        UIView.animateWithDuration(0.5, animations:{ self.enterBudgetLabel.center.x += self.view.bounds.width }, completion: {finished in})
        UIView.animateWithDuration(0.5, animations: { self.enterBudgetTextField.center.x -= self.view.bounds.width}, completion: {finished in })
        labelsHaveAnimated = true
    }
    
    func slideUpBudgetSetterLabel(){
        UIView.animateWithDuration(0.5, animations:{ self.enterBudgetLabel.center.y -= 70}, completion: {finished in})
        UIView.animateWithDuration(0.5, animations: { self.enterBudgetTextField.center.y -= 70}, completion: {finished in})
    }
    
    func slideInBudgetSetterButton(){
        setBudgetButton.hidden = false
        UIView.animateWithDuration(0.5, animations: {self.setBudgetButton.center.y -= 200}, completion: {finished in})
    }
    
    func slideOutModeSetters(){
        UIView.animateWithDuration(0.5, animations: {self.freeSpendButton.center.x -= self.view.bounds.width}, completion: {finished in})
        UIView.animateWithDuration(0.5, animations: {self.budgetModeButton.center.x += self.view.bounds.width}, completion: {finished in self.freeSpendButton.hidden = true; self.budgetModeButton.hidden = true})
        
    }
    
    // MARK: - Text Field Handlers
    @IBAction func editTextField(sender: UITextField) {
        if hasSetBudget {
            enterBudgetTextField.text = "\(setBudget)"
        }
    }
    
    @IBAction func editingDidEnd(sender: UITextField) {
        checkForValidBudgetEntry()
        if enterBudgetTextField.text != "" {
            hasSetBudget = true
            let tempStr = enterBudgetTextField.text
            for c in (tempStr?.characters)! {
                if c == "$" {
                    alreadyFormatted = true
                }
            }
            if alreadyFormatted {
                
            } else {
                setBudget = Double(enterBudgetTextField.text!)!
                enterBudgetTextField.text = "\(formatter.stringFromNumber(setBudget)!)"
                if setBudget > 0.0 {
                    slideInBudgetSetterButton()
                }
            }
        } else {
            hasSetBudget = false
        }
    }
    
    // MARK: - Text Error Checking
    func checkForValidBudgetEntry(){
        var decimalCount = 0
        var postDecimaletterCount = 0
        var decimalUsed = false
        let characters = enterBudgetTextField.text
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
            showIncorrectFormatAlert()
            enterBudgetTextField.text = "0.00"
        } else {
            budgetIsViable = true
        }
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    @IBAction func cancelToSettings(segue:UIStoryboardSegue){}
    
    @IBAction func cancelToSettingsFromTaxInfo(segue:UIStoryboardSegue){}
}
