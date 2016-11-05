//
//  HomeViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/2/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Models
    var nms = NSMyDefaults()
    
    // MARK: - Outlets
    @IBOutlet weak var orangeAddButton: OrangeAddButton!
    @IBOutlet weak var orangeListsButton: OrangeListsButton!
    @IBOutlet weak var orangeMenuButton: OrangeMenuButton!
    @IBOutlet weak var orangeAddListButton: OrangeAddListButton!
    @IBOutlet weak var addListLabel: UILabel!
    @IBOutlet weak var addItemLabel: UILabel!
    @IBOutlet weak var showListsLabel: UILabel!

    // MARK: - Variables
    var didAnimate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabels()
    }
    
    // MARK: - Button Was Pressed Methods
    
    @IBAction func menuButtonWasPressed(_ sender: OrangeMenuButton) {
        if didAnimate {
            hideButtons()
            didAnimate = false
        } else {
            didAnimate = true
            showHiddenButtons()
        }
        
    }
    
    // MARK: - View Setters
    func hideLabels(){
        addListLabel.layer.opacity = 0.0
        addItemLabel.layer.opacity = 0.0
        showListsLabel.layer.opacity = 0.0
    }
    
    
    // MARK: - Animations
    func showHiddenButtons(){
        moveOrangeAddButton()
        moveOrangeListsButton()
        moveOrangeAddListsButton()
        moveAddItemLabel()
        moveAddListLabel()
        moveShowListsLabel()
    }
    
    func hideButtons(){
        resetOrangeAddButton()
        resetOrangeListsButton()
        resetOrangeAddListsButton()
        resetAddItemLabel()
        resetAddListLabel()
        resetShowListsLabel()
    }
    
    func moveOrangeAddButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -100)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddButton.transform = translation})
    }
    
    func resetOrangeAddButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddButton.transform = translation})
    }
    
    func moveOrangeListsButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -200)
        UIView.animate(withDuration: 0.40, animations: {self.orangeListsButton.transform = translation})
    }
    
    func resetOrangeListsButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeListsButton.transform = translation})
    }
    
    func moveOrangeAddListsButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -300)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddListButton.transform = translation})
    }
    
    func resetOrangeAddListsButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddListButton.transform = translation})
    }
    
    func moveAddItemLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: -100.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.addItemLabel.transform = translation
            self.addItemLabel.layer.opacity = 1.0
        })
    }
    
    func resetAddItemLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.addItemLabel.transform = translation
            self.addItemLabel.layer.opacity = 0.0
        })
    }
    
    func moveAddListLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: -300.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.addListLabel.transform = translation
            self.addListLabel.layer.opacity = 1.0
        })
    }
    
    func resetAddListLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.addListLabel.transform = translation
            self.addListLabel.layer.opacity = 0.0
        })
    }
    
    func moveShowListsLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: -200.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.showListsLabel.transform = translation
            self.showListsLabel.layer.opacity = 1.0
        })
    }
    
    func resetShowListsLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {
            self.showListsLabel.transform = translation
            self.showListsLabel.layer.opacity = 0.0
        })
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
