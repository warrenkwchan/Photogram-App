//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-23.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class PhotoService {
    
    static func getPhotos(completion: @escaping ([Photo]) -> Void) -> Void {
        
        // getting a reference to the database
        let dbRef = Database.database().reference()
        
        //make the db call
        dbRef.child("photos").observeSingleEvent(of: .value) { (snapshot) in
            
            //declare an array to hold the photos
            var retrievedPhotots = [Photo]()
            // get the list of snapshots
            let snapshots = snapshot.children.allObjects as? [DataSnapshot]
            
            if let snapshots = snapshots {
                
                for snap in snapshots {
                    
                    let p = Photo(snapshot: snap)
                    
                    if p != nil {
                        
                        retrievedPhotots.insert(p!, at: 0)
                        
                    }
                }
            }
            
            // after parsing the snapshots, call the completion closure
            completion(retrievedPhotots)
        }
        
        
    }
    
    static func savePhoto(image:UIImage, progressUpdate: @escaping(Double) -> Void){
        
        // Get data representation of the image
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            print("Couldn't turn the image into data")
            return
        }
        
        let userid = Auth.auth().currentUser!.uid
        let filename = UUID().uuidString
        
        //get a storage reference
        let ref = Storage.storage().reference().child("images/\(userid)/\(filename).jpg")
        
        
        
        //upload the photo
        let uploadTask = ref.putData(photoData!, metadata: nil){
            (metadata, error) in
            
            if error != nil {
                // an error during upload occured
                
            }
            else {
                
                self.createPhotoDatabaseEntry(ref: ref)
            }
        }
        
        
        uploadTask.observe(.progress) { (snapshot) in
            
            let percentage:Double = Double (snapshot.progress!.completedUnitCount) /
            Double(snapshot.progress!.totalUnitCount) * 100.0
            
            progressUpdate(percentage)
            
            
            
        }
        //create a database entry
        
    }
    
    
    
    
    private static func createPhotoDatabaseEntry(ref:StorageReference) {
        
        // get a download url for the photo
        ref.downloadURL { (url, error) in
            
            if error != nil {
                
                
                return
            }
            else {
                
               //user
                let user = LocalStorageService.loadCurrentUser()
                
                
                guard user != nil else {
                    return
                }
                
                //Date
                let dataFormatter = DateFormatter()
                dataFormatter.dateStyle = .full
                
                let dateString = dataFormatter.string(from: Date())
                
                
                // create photo data
                
                let photoData = ["byId": user!.userId!, "byUsername":user!.username!, "date":dateString, "url":url!.absoluteString ]
                
                
                // write a database entry
                let dbRef = Database.database().reference().child("photos").childByAutoId()
                dbRef.setValue(photoData, withCompletionBlock: { (error, dbRef) in
                    
                    if error != nil {
                        
                        return
                    }
                    else {
                        // Database entry for the photo was written
                    }
                    
                })
                
            }
            
        }
        
        // Write
        
        
        
        
    }
    
    
    
    
}
