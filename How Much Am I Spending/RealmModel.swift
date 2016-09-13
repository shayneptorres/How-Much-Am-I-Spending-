//
//  RealmModel.swift
//  How Much Am I Spending
//
//  Created by Shayne Torres on 9/8/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import RealmSwift

// Handles the Realm DB Actions
class RealmModel {
    
    // Sets the Realm file name to a unique file based on the user's name
    func setDefaultRealmForUser(username: String) {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.URLByDeletingLastPathComponent?
            .URLByAppendingPathComponent("\(username).realm")
        
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }

}