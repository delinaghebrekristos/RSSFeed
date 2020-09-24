//
//  NewsCell.swift
//  gheb4750_A06
//
//  Created by Delina Ghebrekristos on 2020-04-06.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    
    var item: RSSItem! {
        
        didSet{
            newsTitleLabel.text = item.title
            let url = NSURL(string: self.item.imageLink)
            let imageData = NSData(contentsOf: url! as URL)
            let image = UIImage(data: imageData! as Data)
            NewsImage.image = image
            
        }
    }
}
