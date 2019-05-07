//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-19.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CameraViewController: UIViewController {
    
    
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    
    @IBOutlet weak var doneLabel: UILabel!
    

    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        progressRing.alpha = 0
        progressRing.value = 0
        progressRing.maxValue = 100
        progressRing.innerRingColor = .green
        
        // Hide the label and button
        doneLabel.alpha = 0
        doneButton.alpha = 0
        
        
    }
    
   
   
    

    func savePhoto(image:UIImage){
        
        PhotoService.savePhoto(image: image) { (pct) in
            
            self.progressRing.alpha = 1
            
            self.progressRing.startProgress(to: CGFloat(pct), duration: 1)
            
            if pct == 100 {
                self.doneButton.alpha = 1
                self.doneLabel.alpha = 1
            }
            
            
        }
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
        // TODO: Go to photos tab
       let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            // call the goToFeed method
            
            tabBarVC.goToFeed()
            
        }
        
    }
    

}
