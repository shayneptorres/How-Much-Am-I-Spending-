//
//  CurrentSpendingsItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CurrentSpendingsItem: Object {
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var brand = String()
    dynamic var price = Double()
    dynamic var quantity = Double()
    dynamic var isTaxed = Bool()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func autoIncrementPK(){
        let realm = try! Realm()
        var myvalue = realm.objects(CurrentSpendingsItem).map{$0.id}.maxElement() ?? 0
        myvalue = myvalue + 1
        id = myvalue
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
