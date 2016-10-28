
//
//  MyDefaultsManager.swift
//  MyDefaultsManager
//
//  Created by Shayne P Torres on 10/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class NSMyDefaults {
    // NSUserDefaults
    let def = UserDefaults.standard
    
    
    // MARK: - Main UserDefaults Methods
    
    /**
     Clears all of the UserDefault values accross the app. Only use if you want to remove all saved values from NSUserDefaults
     */
    func clearAllData(){
        def.clearAll()
    }
    
    /**
     Stores a given value in NSUserDefaults for the given key
     */
    func set(_ val: AnyObject, forKey: String){
        def.set(val, forKey: forKey)
    }
    
    // getValue: Looks to see if the value for the given key exists
    // if not, then it fails by returning a value of which the type is
    // specified by the 'failWith' argument
    /**
     Attempts to retrieve a value in NSUserDefaults for a given key, if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults. If saveToUserDefaults is true, the function will return the fail value and it will store the fail value into nsuder defaults for the given key
     */
    func getValue(_ forKey: String, failWith: AnyObject, saveToUserDefaults: Bool)->AnyObject?{
        if def.value(forKey: forKey) != nil {
            return def.value(forKey: forKey) as AnyObject?
        } else {
            if saveToUserDefaults {
                set(failWith, forKey: forKey)
            }
            return failWith
        }
    }
    
    // getValue: Looks to see if the value for the given key exists
    // if not, then it fails by returning a value of which the type is
    // specified by the 'failWith' argument
    /**
     Attempts to retrieve a value in NSUserDefaults for a given key, if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults
     */
    func getValue(_ forKey: String, failWith: AnyObject)->AnyObject?{
        if def.value(forKey: forKey) != nil {
            return def.value(forKey: forKey) as AnyObject?
        } else {
            return failWith
        }
    }
    
    // MARK: - Dictionary Methods
    
    // MARK: Mutator Methods
    
    // setUserPrefDictValue: Sets a key-value pair in the UserPrefDict
    func setUserPrefDictValue(_ val: AnyObject, forKey: String){
        setDictValue("uPrefDict", val: val, forKey: forKey)
    }
    
    // setAppPrefDictValue: Sets a key-value pair in the AppPrefDict
    func setAppPrefDictValue(_ val: AnyObject, forKey: String){
        setDictValue("aPrefDict", val: val, forKey: forKey)
    }
    
    // seDictValue: Sets a key-value pair in any Dict
    func setDictValue(_ dictKey: String, val: AnyObject, forKey: String){
        var dict = getDict(dictKey)
        dict[forKey] = val
        set(dict as AnyObject, forKey: dictKey)
    }
    
    /**
     Prints the Dictionary Values to console, mainly used for dev/debugging
     */
    func printDictValues(_ dictKey: String){
        let dict = getDict(dictKey)
        print(dict)
    }
    
    // clearUserPrefDict: Clears out the UserPrefDict values
    func clearUserPrefDict(){
        clearDict("uPrefDict")
    }
    
    // clearUserPrefDict: Clears out the UserPrefDict values
    func clearAppPrefDict(){
        clearDict("aPrefDict")
    }
    
    // clearUserPrefDict: Clears out the UserPrefDict values
    func clearDict(_ dictKey: String){
        set([:] as AnyObject, forKey: dictKey)
    }
    
    // MARK: Accessor Methods
    
    // getUserPrefDict: Retrieves a dictionary of values that conains
    // User information
    func getUserPrefDict()->[String:AnyObject]{
        return getDict("uPrefDict")
    }
    
    /**
     Attempts to retrieve a value in UserPrefDict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults
     */
    // getUserPrefDictValue: Retieves the value for the given key in the userPrefDictos
    func getUserPrefDictValue(_ forKey: String, failWith: AnyObject)->AnyObject?{
        return getDictValue("uPrefDict", forKey: forKey, failWith: failWith)
    }
    
    /**
     Attempts to retrieve a value in UserPrefDict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults. If saveToUserDefaults is true, the function will return the fail value and it will store the fail value into nsuder defaults for the given key
     */
    // getUserPrefDictValue: Retieves the value for the given key in the userPrefDictos
    func getUserPrefDictValue(_ forKey: String, failWith: AnyObject, saveToUserDefaults: Bool)->AnyObject?{
        return getDictValue("uPrefDict", forKey: forKey, failWith: failWith, saveToUserDefaults: saveToUserDefaults)
    }
    
    // getAppPrefDict: Retrieves a dictionary of values that contains
    // application settings
    func getAppPrefDict()->[String:AnyObject]{
        return getDict("aPrefDict")
    }
    
    // getUserPrefDictValue: Retieves the value for the given key in the appPrefDict
    /**
     Attempts to retrieve a value in AppPrefDict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults
     */
    func getAppPrefDictValue(_ forKey: String, failWith: AnyObject)->AnyObject?{
        return getDictValue("aPrefDict", forKey: forKey, failWith: failWith)
    }
    
    // getUserPrefDictValue: Retieves the value for the given key in the appPrefDict
    /**
     Attempts to retrieve a value in AppPrefDict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults. If saveToUserDefaults is true, the function will return the fail value and it will store the fail value into nsuder defaults for the given key
     */
    func getAppPrefDictValue(_ forKey: String, failWith: AnyObject, saveToUserDefaults: Bool)->AnyObject?{
        return getDictValue("aPrefDict", forKey: forKey, failWith: failWith, saveToUserDefaults: saveToUserDefaults)
    }
    
    
    // getDict: Retrieves a custon dictionary that the user can specify with
    // a string 'dict key'
    func getDict(_ dictKey: String)->[String:AnyObject]{
        return getValue(dictKey, failWith: [:] as AnyObject) as! [String:AnyObject]
    }
    
    
    // getDictValue: Retieves the value for the given key in the appPrefDict
    /**
     Attempts to retrieve a value in any Dict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults
     */
    func getDictValue(_ dictKey: String, forKey: String, failWith: AnyObject)->AnyObject?{
        let dict = getValue(dictKey, failWith: [:] as AnyObject) as! [String:AnyObject]
        if dict[forKey] != nil {
            return dict[forKey]
        } else {
            return failWith
        }
    }
    
    // getDictValue: Retieves the value for the given key in the appPrefDict
    /**
     Attempts to retrieve a value in any Dict if it can't it returns a fail value.
     The fail value is the value that the function will return if the given key is not found in NSUserDefaults. If saveToUserDefaults is true, the function will return the fail value and it will store the fail value into nsuder defaults for the given key
     */
    func getDictValue(_ dictKey: String, forKey: String, failWith: AnyObject, saveToUserDefaults: Bool)->AnyObject?{
        let dict = getValue(dictKey, failWith: [:] as AnyObject) as! [String:AnyObject]
        if dict[forKey] != nil {
            return dict[forKey]
        } else {
            if saveToUserDefaults {
                set(failWith, forKey: dictKey)
            }
            return failWith
        }
    }
    
    // MARK: - Array Methods
    
    // MARK: Accessor Methods
    
    // getArray: Retieves an array with the given array key
    func getArray(_ arrKey: String)->[AnyObject]{
        return getValue(arrKey, failWith: [] as AnyObject) as! [AnyObject]
    }
    
    /**
     Prints the Array Values to console, mainly used for dev/debugging
     */
    func printArrayValues(_ arrKey: String){
        let arr = getArray(arrKey)
        print(arr)
    }
    
    // MARK: Mutator Methods
    
    // clearArr: clears the values from the array with the given arraykey
    func clearArr(_ arrKey: String){
        set([] as AnyObject, forKey: arrKey)
    }
    
    
    // append: Appends a given value to an array in the User Defaults
    func append(_ val: AnyObject, toArray: String){
        var arr = getArray(toArray)
        arr.append(val)
        set(arr as AnyObject, forKey: toArray)
    }
}

extension UserDefaults {
    func clearAll() {
        guard let domainName = Bundle.main.bundleIdentifier else {
            return
        }
        
        self.removePersistentDomain(forName: domainName)
    }
}
