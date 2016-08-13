//
//  StatePickerViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 5/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class StatePickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var selectedStateTax: UILabel!
    
    
    var pickerDataSource = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

    var stateTaxDict:[String:Double] = ["Alabama":0.04,"Alaska":0.000,"Arizona":0.056,"Arkansas":0.065,"California":0.075,"Colorado":0.029,"Connecticut":0.0635,"Delaware":0.000,"District of Columbia":0.0575,"Florida":0.06,"Georgia":0.04,"Hawaii":0.04,"Idaho":0.06,"Illinois":0.0625,"Indiana":0.07,"Iowa":0.06,"Kansas":0.065,"Kentucky":0.06,"Louisiana":0.05,"Maine":0.055,"Maryland":0.06,"Massachusetts":0.0625,"Michigan":0.06,"Minnesota":0.06875,"Mississippi":0.07,"Missouri":0.04225,"Montana":0.000,"Nebraska":0.055,"Nevada":0.0685,"New Hampshire":0.000,"New Jersey":0.07,"New Mexico":0.05125,"New York":0.04,"North Carolina":0.0475,"North Dakota":0.05,"Ohio":0.0575,"Oklahoma":0.045,"Oregon":0.000,"Pennsylvania":0.06,"Rhode Island":0.07,"South Carolina":0.06,"South Dakota":0.04,"Tennessee":0.07,"Texas":0.0625,"Utah":0.047,"Vermont":0.06,"Virginia":0.043,"Washington":0.065,"West Virginia":0.06,"Wisconsin":0.05,"Wyoming":0.04]

    var state = String()
    var def = NSUserDefaults.standardUserDefaults()
    var pause = NSTimer()
    var didSetStateIsAnimating = false
    
    @IBOutlet weak var didSelectStateView: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statePicker.dataSource = self;
        self.statePicker.delegate = self
        if def.objectForKey("currentTaxObj") != nil{
            let tempData = def.objectForKey("currentTaxObj") as! NSData
            let encodedData = NSKeyedUnarchiver.unarchiveObjectWithData(tempData) as? TaxObj
            let chosenTaxObj = encodedData!
            var defaultRowIndex = pickerDataSource.indexOf(chosenTaxObj.stateName)
            if(defaultRowIndex == nil) { defaultRowIndex = 0 }
            statePicker.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
        }
        }
    
    func setViewOffSets(){
        didSelectStateView.center.x += self.view.bounds.width
    }
    
    func hideDidSelectSateLabel(){
        didSelectStateView.hidden = true
    }
    
    func unhideDidSelectSateLabel(){
        didSelectStateView.hidden = false
    }
    
    func slidePickerLeft(){
        UIView.animateWithDuration(0.3, animations: {self.statePicker.center.x -= self.view.bounds.width})
        pause = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(StatePickerViewController.slidePickerRight), userInfo: nil, repeats: false)
    }
    
    func slidePickerRight(){
        UIView.animateWithDuration(0.2, animations: {self.statePicker.center.x += self.view.bounds.width}, completion: { finished in self.didSetStateIsAnimating = false})
    }
    
    func slideDidSelectStateViewLeft(){
        didSetStateIsAnimating = true
        didSelectStateView.hidden = false
        UIView.animateWithDuration(0.3, animations: { self.didSelectStateView.center.x -= self.view.bounds.width})
        pause = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(StatePickerViewController.slideDidSelectStateViewRight), userInfo: nil, repeats: false)
    }
    
    func slideDidSelectStateViewRight(){
        UIView.animateWithDuration(0.3, animations: { self.didSelectStateView.center.x += self.view.bounds.width}, completion: {finished in self.hideDidSelectSateLabel()})
        self.didSelectStateView.center.x -= self.view.bounds.width
        hideDidSelectSateLabel()
    }
    
    func setDidSelectStateAppearance(){
        didSelectStateView.text = "Test This"
    }
    
    @IBAction func cancelToSettings(sender: UIButton) {
        performSegueWithIdentifier("cancelToSettings", sender: self)
    }
    
    
    @IBAction func selectState(sender: UIButton) {
        print(stateTaxDict[state]!)
        let taxOb = TaxObj(st: state, tr: stateTaxDict[state]!)
        let tempData = NSKeyedArchiver.archivedDataWithRootObject(taxOb)
        def.setValue(tempData, forKey: "currentTaxObj")
        NSNotificationCenter.defaultCenter().postNotificationName("updateUI", object: nil)
        if didSetStateIsAnimating == false {
            self.didSelectStateView.center.x += self.view.bounds.width
            slidePickerLeft()
            slideDidSelectStateViewLeft()
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        state = pickerDataSource[row]
        let tax = stateTaxDict[state]!
        selectedStateTax.text = ("\(tax)%")
        return pickerDataSource[row]
    }
}
