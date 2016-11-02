//
//  ShoppingListModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListModel {
    
    // ShoppingList Creation Methods
    
    func addCustomShoppingList(list: CustomShoppingList){
        let realm = try! Realm()
        
        let newList = CustomShoppingList()
        newList.id = list.id
        newList.name = list.name
        newList.items = list.items
        try! realm.write {
            realm.add(newList)
        }
    }
    
    func addMealPlan(mp: MealPlan){
        let realm  = try! Realm()
        
        let newMP = MealPlan()
        newMP.id = mp.id
        newMP.days = mp.days
        try! realm.write {
            realm.add(newMP)
        }
    }
    
    // MARK: - ShoppingList Accessor Methods
    func getCustomShoppingListWithID(id: Int)->CustomShoppingList{
        let realm = try! Realm()
        
        let list = realm.objects(CustomShoppingList.self).filter("id = \(id)").first
        return list!
    }
    
    func getMealPlanWithID(id: Int)->MealPlan{
        let realm = try! Realm()
        
        let list = realm.objects(MealPlan.self).filter("id = \(id)").first
        return list!
    }
    
    // MARK: - ShoppingList Mutator Methods
    func editCustomShoppinList(list: CustomShoppingList){
        let realm = try! Realm()
        
        let listToBeEdited = realm.objects(CustomShoppingList.self).filter("id = \(list.id)").first!
        try! realm.write {
            listToBeEdited.id = list.id
            listToBeEdited.name = list.name
            listToBeEdited.items = list.items

        }
    }
    
    func editMealPlan(mp: MealPlan){
        let realm = try! Realm()
        
        let mealPlanToBeEdited = realm.objects(MealPlan.self).filter("id = \(mp.id)").first!
        try! realm.write {
            mealPlanToBeEdited.id = mp.id
            mealPlanToBeEdited.name = mp.name
            mealPlanToBeEdited.days = mp.days
        }
    }
    
    func deleteCustomShoppingList(list: CustomShoppingList){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(list)
        }
    }
    
    func deleteMealPlan(list: MealPlan){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(list)
        }
    }
}
