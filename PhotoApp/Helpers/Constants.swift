//
//  Constants.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-22.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import Foundation


struct Constants{
    struct Storyboard {
        
        static let tabBarController = "MainTabBarController"
        static let loginNavController = "LoginNavController"
        static let feedPhotoTableCellId = "PhotoCell"
    }
    
    struct Segue {
        
        static let profileViewController = "goToCreateProfile"
        
    }
    
    struct LocalStorage {
        static let storedUsername = "storedUsername"
        static let storedUserId = "storedUserId"
        
    }
    
    
}
