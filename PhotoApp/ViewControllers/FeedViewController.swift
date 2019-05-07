//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-19.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // Configure the tableview
        tableView.dataSource = self
        tableView.delegate = self
        
        addRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Retrieve and display the photos
        PhotoService.getPhotos { (photos) in
            
            self.photos = photos
            self.tableView.reloadData()
            
            
        }
    }
    
    func addRefreshControl(){
        
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshInitiated(refreshControl:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshInitiated(refreshControl:UIRefreshControl) {
    
    // call the photo service retrieve photos
    PhotoService.getPhotos { (photos) in
        
        self.photos = photos
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        
        
    }
        
    }
    
    

}


extension FeedViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.feedPhotoTableCellId, for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.row]
        
        
        cell.setPhoto(photo)
        
        return cell 
    }
    
    
    
    
}
