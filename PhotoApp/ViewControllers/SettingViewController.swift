//
//  SettingViewController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-19.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: UIButton) {
        
        do{
            
            
            //Sign out using Firebase auth methods
           try Auth.auth().signOut()
            
            //Clear local storage
            LocalStorageService.clearCurrentUser()
            
            // Change the window to show the login screen
            let LoginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginNavController)
            
            view.window?.rootViewController = LoginVC
            view.window?.makeKeyAndVisible()
            
        }
        catch {
            // Error signing out
            print("Couldn't sign out" )
        }
      
        
    }
    

}
