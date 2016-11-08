//
//  HomeViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/2/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Models
    var nms = NSMyDefaults()
    let realm = try! Realm()
    
    // MARK: - Outlets
    @IBOutlet weak var orangeAddButton: OrangeAddButton!
    @IBOutlet weak var orangeListsButton: OrangeListsButton!
    @IBOutlet weak var orangeMenuButton: OrangeMenuButton!
    @IBOutlet weak var orangeAddListButton: OrangeAddListButton!
    @IBOutlet weak var addListLabel: UILabel!
    @IBOutlet weak var addItemLabel: UILabel!
    @IBOutlet weak var showListsLabel: UILabel!
    @IBOutlet weak var shoppingListTableView: UITableView! {
        didSet{
            
        }
    }

    

    // MARK: - Variables
    var didAnimate = Bool()
    var lists = [ShoppingList]()
    var verticalTranslation = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabels()
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        getAllStoredListTypes()
        shoppingListTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lists.removeAll()
        getAllStoredListTypes()
        shoppingListTableView.reloadData()
        setVerticalTranslation()
    }
    
    // MARK: - Button Was Pressed Methods
    
    @IBAction func menuButtonWasPressed(_ sender: OrangeMenuButton) {
        // Test Portion, this call to "getAllStoredLists" will be removed later
        
        if didAnimate {
            hideButtons()
            didAnimate = false
        } else {
            didAnimate = true
            showHiddenButtons()
        }
    }
    
    @IBAction func addListButtonWasPressed(_ sender: OrangeAddListButton) {
        performSegue(withIdentifier: "addList", sender: self)
    }
    
    // MARK: - Data Gathering Methods
    func getAllStoredListTypes(){
        getAllStoredCustomShoppingLists()
        getAllStoredMealPlans()
        getAllStoredCurrentSpendingsLists()
    }
    
    func getAllStoredCustomShoppingLists(){
        let storedLists = realm.objects(CustomShoppingList.self)
        for i in storedLists {
            lists.append(i)
        }
        print(lists)
    }
    
    func getAllStoredMealPlans(){
        let storedLists = realm.objects(MealPlan.self)
        for i in storedLists {
            lists.append(i)
        }
        print(lists)
    }
    
    func getAllStoredCurrentSpendingsLists(){
        let storedLists = realm.objects(CurrentSpendingsList.self)
        for i in storedLists {
            lists.append(i)
        }
        print(lists)
    }
    
    
    
    // MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! CustomShoppingListTableViewCell
        if lists[indexPath.row] is CustomShoppingList {
            cell.list = lists[indexPath.row] as! CustomShoppingList
        }
        
        if lists[indexPath.row] is MealPlan {
            cell.list = lists[indexPath.row] as! MealPlan
        }
        
        if lists[indexPath.row] is CurrentSpendingsList {
            cell.list = lists[indexPath.row] as! CurrentSpendingsList
        }
        return cell
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
    
    func setVerticalTranslation(){
        
        verticalTranslation = CGFloat(self.view.frame.height/8)
    }
    
    func moveOrangeAddButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -verticalTranslation)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddButton.transform = translation})
    }
    
    func resetOrangeAddButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddButton.transform = translation})
    }
    
    func moveOrangeListsButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -(verticalTranslation*2))
        UIView.animate(withDuration: 0.40, animations: {self.orangeListsButton.transform = translation})
    }
    
    func resetOrangeListsButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeListsButton.transform = translation})
    }
    
    func moveOrangeAddListsButton(){
        let translation = CGAffineTransform.init(translationX: 0, y: -(verticalTranslation*3))
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddListButton.transform = translation})
    }
    
    func resetOrangeAddListsButton(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.40, animations: {self.orangeAddListButton.transform = translation})
    }
    
    func moveAddItemLabel(){
        let translation = CGAffineTransform.init(translationX: 0.0, y: -(verticalTranslation))
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
        let translation = CGAffineTransform.init(translationX: 0.0, y: -(verticalTranslation*3))
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
        let translation = CGAffineTransform.init(translationX: 0.0, y: -(verticalTranslation*2))
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
    
    // MARK: - Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "addList":
            let snvc = segue.destination as! SegueNavigationViewController
            snvc.segueIdentifier = "showAddShoppingListVC"
            break
        default:
            break
        }
    }
    
    @IBAction func unwindBackToHomeVC(sender: UIStoryboardSegue){}

}
