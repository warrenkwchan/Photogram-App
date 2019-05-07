//
//  LocalStorageSerivce.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-22.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    static func saveCurrentUser(user:PhotoUser){
        
        let defaults = UserDefaults.standard
        
        defaults.set(user.userId, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(user.username, forKey: Constants.LocalStorage.storedUsername)
        
        
    }
    
    static func loadCurrentUser() -> PhotoUser? {
        
        let defaults = UserDefaults.standard
        
        let username = defaults.value(forKey: Constants.LocalStorage.storedUsername) as? String
        let userId = defaults.value(forKey: Constants.LocalStorage.storedUserId) as? String
        guard username != nil && userId != nil else {
            return nil
        }
        
        let u = PhotoUser(username:username!, userId: userId!)
        return u
        
    }
    
    static func clearCurrentUser() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(nil, forKey: Constants.LocalStorage.storedUsername)
    }
    
    
}
