//
//  ShoppingListViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 6/20/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var tableView: UITableView!
    
//    let tk = TestKit()view
    var color = UIColor(netHex:0x25FB79)
    var items = [Item]()
    var def = NSUserDefaults.standardUserDefaults()
    var iMod = ItemModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        header.backgroundColor = color
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShoppingListViewController.reloadTableData(_:)), name: "reloadShoppingList", object: nil)
        if def.objectForKey("shoppingList") != nil {
            let itemsList = def.objectForKey("shoppingList") as! NSData
            let encodedItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as! [Item]
            self.items = encodedItemsData
        } else {
            
        }
    }
    
    
    
    @IBAction func addItem(sender: UIButton) {
    }
    
    func reloadTableData(notification: NSNotification) {
        reloadShoppingList()
    }
    
    func reloadShoppingList(){
        items = iMod.getList("shoppingList")
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EditShoppingItem":
                let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
                if let esivc = segue.destinationViewController as?
                    EditShoppingItemViewController {
                    esivc.item = self.items[indexPath.row]
                }
            default: break
            }
        }
    }
    
    
    func clearAll() {
        iMod.clearList("shoppingList")
        reloadShoppingList()
    }
    
    
    
    @IBAction func ShowClearAllAlert(sender: UIButton) {
        let clearAllAlert = UIAlertController(title: "Clear All", message: "Are you sure you want to clear all items on the current list?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(
        title: "Yes", style: UIAlertActionStyle.Destructive) { (action) in
            self.clearAll()
        }
        let dissmissAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (action) in}
        clearAllAlert.addAction(confirmAction)
        clearAllAlert.addAction(dissmissAction)
        self.presentViewController(clearAllAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelToShoppingList(sender: UIStoryboardSegue){}
    
    // Swipe to delete table view cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
            def.setObject(currentListData, forKey: "shoppingList")
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shoppingCell") as! ShoppingListCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(items[indexPath.row].checked)
        if items[indexPath.row].checked != true {
            print("did set to true")
            iMod.editItemToList("shoppingList", tl: "currentTripItems", i: items[indexPath.row], n: items[indexPath.row].name, b: items[indexPath.row].brand, p: items[indexPath.row].price, q: items[indexPath.row].quantity, t: items[indexPath.row].taxed, c: true)
        } else {
            print("did set to false")
            iMod.editItemToList("shoppingList", tl: "currentTripItems", i: items[indexPath.row], n: items[indexPath.row].name, b: items[indexPath.row].brand, p: items[indexPath.row].price, q: items[indexPath.row].quantity, t: items[indexPath.row].taxed, c: false)
        }
        reloadShoppingList()
    }

}
