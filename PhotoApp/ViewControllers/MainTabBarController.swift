//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-22.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            // then the add tab is selected
            
           // show the action sheet
            showActionSheet()
        }
        
    }
    
    func showActionSheet() {
        
        // create action sheet
       let actionSheet =  UIAlertController(title: "Add Photo", message: "Select a source:", preferredStyle: .actionSheet)
        
        // create actions
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                
                self.showImagePicker(type: .camera)
                
            }
            
            actionSheet.addAction(cameraAction)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) {(action) in
                
                self.showImagePicker(type: .photoLibrary)
                
            }
            actionSheet.addAction(libraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cancelAction)
        
        //present action sheet
        
        present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func showImagePicker(type:UIImagePickerController.SourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion : nil)
        
    }
}


extension MainTabBarController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
           // user cancelled, dismiss image picker
            picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // successfully got the image, now upload it
        
        
            // get a reference to the camera view controller and call the savePhoto method
       let cameraVC = self.selectedViewController as? CameraViewController
        
        if let cameraVC = cameraVC {
            cameraVC.savePhoto(image: selectedImage)
        }
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func goToFeed() {
        
        selectedIndex = 0 
    }
    
    
    
}
