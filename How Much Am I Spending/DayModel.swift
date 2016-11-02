//
//  DayModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class DayModel {
    // Day Creation Methods
    func addDay(day: Day){
        let realm = try! Realm()
        
        let newDay = Day()
        newDay.id = day.id
        newDay.date = day.date
        newDay.note = day.note
        newDay.meals = day.meals
        newDay.mealPlan = day.mealPlan
        
        try! realm.write {
            realm.add(newDay)
        }
    }

    // Day Accessor Methods
    
    func getDayWithID(id: Int)->Day{
        let realm = try! Realm()
        
        let day = realm.objects(Day.self).filter("id = \(id)").first
        return day!
    }
    
    // Day Mutator Methods
    
    func editDay(day: Day){
        let realm = try! Realm()
        
        let dayToBeEdited = realm.objects(Day.self).filter("id = \(day.id)").first!
        try! realm.write {
            dayToBeEdited.id = day.id
            dayToBeEdited.date = day.date
            dayToBeEdited.note = day.note
            dayToBeEdited.meals = day.meals
            dayToBeEdited.mealPlan = day.mealPlan
        }
    }
    
    func deleteDay(day: Day){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(day)
        }
    }
    
}
