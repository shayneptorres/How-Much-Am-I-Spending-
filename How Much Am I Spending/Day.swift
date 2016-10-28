//
//  Day.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class Day : Object {
    dynamic var id = Int()
    dynamic var date = NSDate()
    var meals = List<Meal>()
    dynamic var mealPlan: MealPlan?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func autoIncrementPK(){
        let realm = try! Realm()
        var myvalue = realm.objects(Day.self).map{$0.id}.max() ?? 0
        myvalue = myvalue + 1
        id = myvalue
    }
}
