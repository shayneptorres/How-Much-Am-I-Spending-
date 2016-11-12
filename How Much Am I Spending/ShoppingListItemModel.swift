//
//  ShoppingListItemModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 10/28/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListItemModel {

    // MARK: - ShoppingListItem Creation Methods
    
    /**
     Given a ShoppingListItem, adds it to the Realm Database
     */
    func addShoppingListItem(item: ShoppingListItem){
        let realm = try! Realm()
        
        let i = ShoppingListItem()
        i.id = item.id
        i.name = item.name
        i.brand = item.brand
        i.quantity = item.quantity
        i.note = item.note
        
        try! realm.write {
            realm.add(i)
        }
    }
    
    /**
     Given a CurrentSpendingsItem, adds it to the Realm Database
     */
    func addCurrentSpendingsItem(cSItem: SpendingsItem){
        let realm = try! Realm()
        
        let csi = SpendingsItem()
        csi.id = cSItem.id
        csi.name = cSItem.name
        csi.brand = cSItem.brand
        csi.quantity = cSItem.quantity
        csi.note = cSItem.note
        csi.price = cSItem.price
        csi.isTaxed = cSItem.isTaxed
        
        try! realm.write {
            realm.add(csi)
        }
    }
    
    // MARK: - ShoppingListItem Accessor Methods
    
    func getShoppingListItemWithID(id: Int)->ShoppingListItem{
        let realm = try! Realm()
        
        let item = realm.objects(ShoppingListItem.self).filter("id = \(id)").first
        return item!
    }
    
    func getCurrentSpendingsItemWithID(id: Int)->SpendingsItem{
        let realm = try! Realm()
        
        let item = realm.objects(SpendingsItem.self).filter("id = \(id)").first
        return item!
    }
    
    // MARK: - ShoppingListItem Mutator Methods
    
    func editShoppingListItem(item: ShoppingListItem){
        let realm = try! Realm()
        
        let itemToBeEdited = realm.objects(ShoppingListItem.self).filter("id = \(item.id)").first!
        try! realm.write {
            itemToBeEdited.id = item.id
            itemToBeEdited.name = item.name
            itemToBeEdited.brand = item.brand
            itemToBeEdited.quantity = item.quantity
            itemToBeEdited.note = item.note
        }
    }
    
    func editCurrentSpendingsItem(item: SpendingsItem){
        let realm = try! Realm()
        
        let itemToBeEdited = realm.objects(SpendingsItem.self).filter("id = \(item.id)").first!
        try! realm.write {
            itemToBeEdited.id = item.id
            itemToBeEdited.name = item.name
            itemToBeEdited.brand = item.brand
            itemToBeEdited.quantity = item.quantity
            itemToBeEdited.note = item.note
            itemToBeEdited.price = item.price
            itemToBeEdited.isTaxed = item.isTaxed
        }
    }
    
    func deleteShoppingListItem(item: ShoppingListItem){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
    
    func deleteCurrentSpendingsItem(item: SpendingsItem){
        let realm  = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
    
    
}
