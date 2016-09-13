//
//  CurrentSpendingsModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CurrentSpendingsModel {
    // Variables
    
    // Adds a CSItem to database
    func addCSItem(csitem: CurrentSpendingsItem){
        let realm = try! Realm()
        try! realm.write {
            csitem.autoIncrementPK()
            realm.add(csitem, update: true)
        }
    }
    
    // Read CSItems from database
    func readCSItems()->Results<CurrentSpendingsItem>{
        let realm = try! Realm()
        return realm.objects(CurrentSpendingsItem.self) 
    }
}