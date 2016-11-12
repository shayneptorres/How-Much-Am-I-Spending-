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
        newList.autoIncrementPK()
        newList.name = list.name
        newList.notes = list.notes
        newList.items = list.items
        try! realm.write {
            realm.add(newList)
        }
    }
    
    func addMealPlan(mp: MealPlan){
        let realm  = try! Realm()
        
        let newMP = MealPlan()
        newMP.autoIncrementPK()
        newMP.name = mp.name
        newMP.notes = mp.notes
        newMP.days = mp.days
        try! realm.write {
            realm.add(newMP)
        }
    }
    
    func addCurrentSpendingsList(sl: SpendingsList){
        let realm = try! Realm()
        
        let newSpendingsList = SpendingsList()
        newSpendingsList.name = sl.name
        newSpendingsList.notes = sl.notes
        newSpendingsList.autoIncrementPK()
        newSpendingsList.items = sl.items
        try! realm.write {
            realm.add(sl)
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
    
    func getCurrentSpendingsListWithID(id: Int)->SpendingsList{
        let realm = try! Realm()
        
        let list = realm.objects(SpendingsList.self).filter("id = \(id)").first
        return list!
    }
    
    // MARK: - ShoppingList Mutator Methods
    func editCustomShoppinList(list: CustomShoppingList){
        let realm = try! Realm()
        
        let listToBeEdited = realm.objects(CustomShoppingList.self).filter("id = \(list.id)").first!
        try! realm.write {
            listToBeEdited.id = list.id
            listToBeEdited.notes = list.notes
            listToBeEdited.name = list.name
            listToBeEdited.items = list.items

        }
    }
    
    func editMealPlan(mp: MealPlan){
        let realm = try! Realm()
        
        let mealPlanToBeEdited = realm.objects(MealPlan.self).filter("id = \(mp.id)").first!
        try! realm.write {
            mealPlanToBeEdited.id = mp.id
            mealPlanToBeEdited.notes = mp.notes
            mealPlanToBeEdited.name = mp.name
            mealPlanToBeEdited.days = mp.days
        }
    }
    
    func editCurrentSpendingsList(csl: SpendingsList){
        let realm = try! Realm()
        
        let currentSpendingsListToBeEdited = realm.objects(SpendingsList.self).filter("id = \(csl.id)").first!
        try! realm.write {
            currentSpendingsListToBeEdited.id = csl.id
            currentSpendingsListToBeEdited.notes = csl.notes
            currentSpendingsListToBeEdited.name = csl.name
            currentSpendingsListToBeEdited.items = csl.items
            
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
    
    func deleteCurrentSpendingsList(list: SpendingsList){
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(list)
        }
    }
    
}
