//
//  ItemModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 6/21/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class ItemModel{
    let def = NSUserDefaults.standardUserDefaults()
    
    func addItemToList(l:String, i:Item){
        var items = [Item]()
        if def.objectForKey(l) != nil {
            items = getList(l)
        } else {
            items = []
        }
        items.insert(i, atIndex: 0)
        let listData = NSKeyedArchiver.archivedDataWithRootObject(items)
        def.setObject(listData, forKey: l)
    }
    
    func getList(l:String)->[Item]{
        var items = [Item]()
        if def.objectForKey(l) != nil {
            let itemsList = def.objectForKey(l) as! NSData
            let encodedItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as! [Item]
            items = encodedItemsData
        } else {
            items = []
        }
        return items
    }
    
    func clearList(l:String){
        var i = [Item]()
        i = []
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(i)
        def.setObject(currentListData, forKey: l)
    }
    
    func deleteItemFromList(l:String, i:Item){
        var items = [Item]()
        let itemsList = def.objectForKey(l) as! NSData
        let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
        items = encodedCurrentItemsData!
        var index = Int()
        index = findIndexofItem(i, l: items)
        items.removeAtIndex(index)
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        def.setObject(currentListData, forKey: l)
        
    }
    
    func editItemToList(fl:String, tl:String, i:Item, n: String, b: String, p: Double, q: Double, t: Bool, c:Bool){
        var fromListItems = [Item]()
        if def.objectForKey(fl) != nil {
            fromListItems = getList(fl)
        } else {
            fromListItems = []
        }
        var index = 0
        index = findIndexofItem(i, l: fromListItems)
        updateItem(i, n: n, b: b, p: p, q: q, t: t, c: c)
        fromListItems.removeAtIndex(index)
        fromListItems.insert(i, atIndex: index)
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(fromListItems)
        def.setObject(currentListData, forKey: fl)
        
        var toListItems = [Item]()
        if def.objectForKey(tl) != nil {
            toListItems = getList(tl)
        } else {
            toListItems = []
        }
        toListItems.insert(i, atIndex: 0)
//        currentListData = NSKeyedArchiver.archivedDataWithRootObject(toListItems)
//        def.setObject(currentListData, forKey: tl)
    }
    
    func updateItem(i:Item, n: String, b: String, p: Double, q: Double, t: Bool, c: Bool){
        i.name = n
        i.brand = b
        i.price = p
        i.quantity = q
        i.taxed = t
        i.checked = c
    }
    
    func findIndexofItem(i: Item, l: [Item])->Int{
        var index = 0
        for j in l {
            if j.itemNo == i.itemNo {
                index = l.indexOf(j)!
            }
        }
        return index
    }
}
