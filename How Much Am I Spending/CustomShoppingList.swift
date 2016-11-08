//
//  CustomShoppingList.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class CustomShoppingList : ShoppingList {
    var items = List<ShoppingListItem>()
    
    override func autoIncrementPK(){
        let realm = try! Realm()
        var myvalue = realm.objects(CustomShoppingList.self).map{$0.id}.max() ?? 0
        myvalue = myvalue + 1
        id = myvalue
    }
}
