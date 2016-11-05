//
//  WelcomeViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Models
    var nmd = NSMyDefaults()
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: WelcomeVCTextField!
    @IBOutlet weak var confirmButton: orangeLongButton!
    @IBOutlet weak var bottomWelcomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Button Was Pressed Methods
    
    @IBAction func confrimButtonWasPressed(_ sender: orangeLongButton) {
        let name = nameTextField.text!
        nmd.setUserPrefDictValue(name as AnyObject, forKey: "name")
        performSegue(withIdentifier: "showHomeVC", sender: self)
    }
    
    // MARK: - Animations
    func moveConfirmButtonUp(){
        let verticalTranform = CGAffineTransform.init(translationX: 0.0, y: -300.0)
        confirmButton.transform = verticalTranform
    }
    
    func moveConfirmButtonDown(){
        let verticalTranform = CGAffineTransform.init(translationX: 0.0, y: 0)
        confirmButton.transform = verticalTranform
    }
    
    func moveBottomWelcomLabelRight(){
        let horizontalTransfrom = CGAffineTransform.init(translationX: self.view.bounds.width, y: 0.0)
        bottomWelcomLabel.transform = horizontalTransfrom
    }
    
    func resetBottomWelcomLabel(){
        let horizontalTransfrom = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        bottomWelcomLabel.transform = horizontalTransfrom
    }
    
    // MARK: - TextField Methods
    
    @IBAction func textFieldDidBeginEditing(_ sender: WelcomeVCTextField) {
        UIView.animate(withDuration: 0.75,
                       animations: {
                        self.moveConfirmButtonUp()
                        self.moveBottomWelcomLabelRight()
            },
                       completion: {finished in})
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.75,
                       animations: {
                        self.moveConfirmButtonDown()
                        self.resetBottomWelcomLabel()
            },
                       completion: {finished in})
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
