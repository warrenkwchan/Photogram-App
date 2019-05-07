//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Warren Chan on 2019-04-24.
//  Copyright © 2019 Warren Chan. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPhoto(_ photo:Photo) {
        
        usernameLabel.text = photo.byUsername
        dateLabel.text = photo.date
        
        if let urlString = photo.url {
            
            let url = URL (string: urlString)
            
            guard url != nil else {
                
                return
            }
            
            cellImageView.sd_setImage(with: url) { (image, error , cacheType, url) in
                
                
                self.cellImageView.image = image
                
            }
            
            
        }
        
    
       
        
    }

}
