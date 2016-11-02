//
//  Meal.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class Meal : Object{
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var note = String()
    var shoppingList = List<ShoppingList>()
    var day:Day?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func autoIncrementPK(){
        let realm = try! Realm()
        var myvalue = realm.objects(Meal.self).map{$0.id}.max() ?? 0
        myvalue = myvalue + 1
        id = myvalue
    }
}
