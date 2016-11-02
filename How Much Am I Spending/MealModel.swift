//
//  MealModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class MealModel {
    // Meal Creation Methods
    
    func addMeal(m: Meal){
        let realm = try! Realm()
        
        let newMeal = Meal()
        newMeal.id = m.id
        newMeal.name = m.name
        newMeal.note = m.note
        newMeal.day = m.day
        newMeal.shoppingList = m.shoppingList
        
        try! realm.write {
            realm.add(newMeal)
        }
    }
    
    // Meal Accessor Methods
    
    func getMealWithID(id: Int)->Meal{
        let realm = try! Realm()
        
        let meal = realm.objects(Meal.self).filter("id = \(id)").first
        return meal!
    }
    
    // Meal Mutator Methods
    
    func editMeal(meal: Meal){
        let realm = try! Realm()
        
        let mealToBeEdited = realm.objects(Meal.self).filter("id = \(meal.id)").first!
        try! realm.write {
            mealToBeEdited.id = meal.id
            mealToBeEdited.name = meal.name
            mealToBeEdited.note = meal.note
            mealToBeEdited.day = meal.day
            mealToBeEdited.shoppingList = meal.shoppingList
            
        }
    }
    
    func deleteMeal(meal: Meal){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(meal)
        }
    }
}
