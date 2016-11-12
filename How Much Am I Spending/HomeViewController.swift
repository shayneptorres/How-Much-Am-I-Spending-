//
//  HomeViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/2/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Models
    var nms = NSMyDefaults()
    let realm = try! Realm()
    let slMod = ShoppingListModel()
    
    // MARK: - Outlets
    @IBOutlet weak var orangeAddButton: OrangeAddButton!
    @IBOutlet weak var orangeListsButton: OrangeFilterButton!
    @IBOutlet weak var orangeMenuButton: OrangeMenuButton!
    @IBOutlet weak var orangeAddListButton: OrangeAddListButton!
    @IBOutlet weak var addListLabel: UILabel!
    @IBOutlet weak var addItemLabel: UILabel!
    @IBOutlet weak var showListsLabel: UILabel!
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var listSearchBar: UISearchBar!

    

    // MARK: - Variables
    var didAnimate = Bool()
    var lists = [ShoppingList]()
    var filteredLists = [ShoppingList]()
    var verticalTranslation = CGFloat()
    var filterString = String()
    var isFiltering = Bool()
    var chosenList = ShoppingList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabels()
        listSearchBar.delegate = self
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
    
    @IBAction func addItemButtonWasPressed(_ sender: OrangeAddButton) {
        performSegue(withIdentifier: "addItem", sender: self)
    }
    
    @IBAction func addListButtonWasPressed(_ sender: OrangeAddListButton) {
        performSegue(withIdentifier: "addList", sender: self)
    }
    
    // MARK: - Data Gathering Methods
    func getAllStoredListTypes(){
        getAllStoredCustomShoppingLists()
        getAllStoredMealPlans()
        getAllStoredSpendingsLists()
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
    
    func getAllStoredSpendingsLists(){
        let storedLists = realm.objects(SpendingsList.self)
        for i in storedLists {
            lists.append(i)
        }
        print(lists)
    }
    
    func getAllListsWithFilteredName(){
        filteredLists.removeAll()
        for i in lists {
            if i.name.lowercased().contains(filterString.lowercased()) {
                filteredLists.append(i)
            }
        }
    }
    
    // MARK: - Search Bar Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isFiltering {
            filterString = searchText
            getAllListsWithFilteredName()
        }
        if searchText == "" {
            filteredLists = lists
        }
        shoppingListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        listSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        listSearchBar.resignFirstResponder()
    }
    
    // MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredLists.count
        } else {
            return lists.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            chosenList = filteredLists[indexPath.row]
        } else {
            chosenList = lists[indexPath.row]
        }
        performSegue(withIdentifier: "showListDetailsVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! CustomShoppingListTableViewCell
            if filteredLists[indexPath.row] is CustomShoppingList {
                cell.list = filteredLists[indexPath.row] as! CustomShoppingList
            }
            
            if filteredLists[indexPath.row] is MealPlan {
                cell.list = filteredLists[indexPath.row] as! MealPlan
            }
            
            if filteredLists[indexPath.row] is SpendingsList {
                cell.list = filteredLists[indexPath.row] as! SpendingsList
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! CustomShoppingListTableViewCell
            if lists[indexPath.row] is CustomShoppingList {
                cell.list = lists[indexPath.row] as! CustomShoppingList
            }
            
            if lists[indexPath.row] is MealPlan {
                cell.list = lists[indexPath.row] as! MealPlan
            }
            
            if lists[indexPath.row] is SpendingsList {
                cell.list = lists[indexPath.row] as! SpendingsList
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isFiltering {
                filteredLists.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if filteredLists[indexPath.row] is CustomShoppingList {
                    slMod.deleteCustomShoppingList(list: filteredLists[indexPath.row] as! CustomShoppingList)
                }
                
                if filteredLists[indexPath.row] is MealPlan {
                    slMod.deleteMealPlan(list: filteredLists[indexPath.row] as! MealPlan)
                }
                
                if filteredLists[indexPath.row] is SpendingsList {
                    slMod.deleteSpendingsList(list: filteredLists[indexPath.row] as! SpendingsList)
                }
            } else {
                lists.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if lists[indexPath.row] is CustomShoppingList {
                    slMod.deleteCustomShoppingList(list: lists[indexPath.row] as! CustomShoppingList)
                }
                
                if lists[indexPath.row] is MealPlan {
                    slMod.deleteMealPlan(list: lists[indexPath.row] as! MealPlan)
                }
                
                if lists[indexPath.row] is SpendingsList {
                    slMod.deleteSpendingsList(list: lists[indexPath.row] as! SpendingsList)
                }
            }
            
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
    
    func rotateMenuButton(){
    }
    
    // MARK: - Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "addList":
            let snvc = segue.destination as! SegueNavigationViewController
            snvc.segueIdentifier = "showAddShoppingListVC"
            break
        case "showListDetailsVC":
            let ldvc = segue.destination as! ListDetailsViewController
            ldvc.list = chosenList
            break
        default:
            break
        }
    }
    
    @IBAction func unwindBackToHomeVC(sender: UIStoryboardSegue){}

}
