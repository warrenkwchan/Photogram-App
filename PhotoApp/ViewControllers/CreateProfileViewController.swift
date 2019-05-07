//
//  CreateProfileViewController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-19.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmTapped(_ sender: UIButton) {
        // chech that there is a user logged in because we need th uid
        guard Auth.auth().currentUser != nil else {
            
            print("No User logged in")
            return
        }
        
        // check that the textfield has a valid name
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //call user service to create the profile
        guard username != nil && username != "" else {
            print("Bad uername")
            return
        }
        
        UserService.createUserProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (u) in
            
            
            //Check if the profile was created
            if u == nil {
                // Error occurred in profile saving
                return
            }
            
            else {
                
                //Save user to local storage
                LocalStorageService.saveCurrentUser(user: u!)
                
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
                
            }
            
            
        }
        // GO to the tab bar controller
        
        
        
        
        
    }
    

}
