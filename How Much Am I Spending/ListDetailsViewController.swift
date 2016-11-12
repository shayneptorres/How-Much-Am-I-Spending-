//
//  ListDetailsViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import RealmSwift

class ListDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var listDetailsTableView: UITableView!
    @IBOutlet weak var progressIndicator: ProgressIndicator!
    
    // MARK: - Models
    
    // MARK: - Variables
    var list = ShoppingList()
    var items = [ShoppingListItem]()
    var progress = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArrayOfItemsFromList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data Gathering Methods
    func getArrayOfItemsFromList(){
        if list is CustomShoppingList {
            let csl = list as! CustomShoppingList
            
            for i in csl.items {
                items.append(i)
            }
        }
        
        if list is CurrentSpendingsList {
            let csl = list as! CurrentSpendingsList
            for i in csl.items {
                items.append(i)
            }
        }
    }
    
    // MARK: - UI Methods
    func updateProgressIndicator(prog: CGFloat){
        progressIndicator.progress = prog
        progressIndicator.setNeedsDisplay()
    }
    
    // MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
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
