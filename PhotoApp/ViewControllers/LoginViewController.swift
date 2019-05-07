//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-19.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // created a firebase auth ui object
        let authUI = FUIAuth.defaultAuthUI()
        
        // check that it isn't nil
        if let authUI = authUI {
            
            // create a firebase auth pre build UI View Controller
            let authViewController = authUI.authViewController()
            // Set the login view controller as the delegate
            
            authUI.delegate = self
            let providers:[FUIAuthProvider] = [FUIEmailAuth()]
            authUI.providers = providers
            
            // Present it
            let provider = authUI.providers.first as! FUIEmailAuth
            provider.signIn(withPresenting: self, email: nil)
            present(authViewController, animated: true)
            
        }
    }
    
}


extension LoginViewController:FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check if an error occurred
        guard error == nil else {
            print("AN error has happend")
            return
        }
        
        //Get the user
        let user = authDataResult?.user
        
        // Check if user is nil
        if let user = user {
            
            UserService.getUserProfile(userId: user.uid) { (u) in
                
                if u == nil{
                    
                    self.performSegue(withIdentifier: Constants.Segue.profileViewController, sender: self)
                    
                }
                
                else{
                    
                    // Save the logged in user to local storage
                    LocalStorageService.saveCurrentUser(user: u!)
                    
                    
                    let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                    
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
                
                
            }
            
         
            
        }
        
        
    }
}
