//
//  UserService.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-22.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserService {
    
    static func createUserProfile(userId:String, username:String, completion: @escaping (PhotoUser?) -> Void) -> Void{
        
        let userProfileData = ["username":username]
        
        let ref = Database.database().reference()
        
        ref.child("users").child(userId).setValue(userProfileData) {
            (error, ref) in
            
            if error != nil {
                
                completion(nil)
            }
            else {
                
                // create the user and pass it back
                let u = PhotoUser(username: username, userId: userId)
                
                completion(u)
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
        static func getUserProfile(userId:String, completion: @escaping (PhotoUser?) -> Void) -> Void {
        
        
        // get a databse reference
        let ref = Database.database().reference()
        
        // Try to retrieve the profile for the passed in userid
        ref.child("users").child(userId).observeSingleEvent(of: .value)
        { (snapshot) in
        
            // check the return snapshot value to see if there's a profile
            if let userProfileData = snapshot.value as? [String:Any] {
                
                var u = PhotoUser()
                u.userId = snapshot.key
                u.username = userProfileData["username"] as? String
                // this means there is a profile
                completion(u)
            }
            
            else{
                
                completion(nil)
                
                
            }
            
            
        }
        
        
    }
    
    
    
}
