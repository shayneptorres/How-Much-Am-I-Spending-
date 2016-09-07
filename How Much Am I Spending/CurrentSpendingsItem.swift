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
    dynamic var name = String()
    dynamic var brand = String()
    dynamic var price = Double()
    dynamic var quantity = Int()
    dynamic var isTaxed = Bool()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
