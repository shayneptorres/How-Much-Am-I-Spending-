//
//  CurrentSpendingsItem.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class CurrentSpendingsItem : ShoppingListItem {
    dynamic var price = Double()
    dynamic var isTaxed = Bool()
}
