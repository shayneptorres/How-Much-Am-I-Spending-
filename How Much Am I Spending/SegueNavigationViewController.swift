//
//  SegueNavigationViewController.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 11/5/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class SegueNavigationViewController: UINavigationController {
    var segueIdentifier = String()
    var list = ShoppingList()

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: segueIdentifier, sender: self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showAddShoppingListVC":
            break
        default:
            break
        }
    }
}
