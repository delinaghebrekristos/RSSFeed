//
//  DetailViewController.swift
//  gheb4750_A06
//
//  Created by Delina Ghebrekristos on 2020-04-06.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import Foundation
import UIKit

protocol navigateNewsDelegate {
    func navigateNews(rssitem: RSSItem)
}


class DetailViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsTitle: UINavigationItem!
    @IBOutlet weak var newsDescription: UILabel!
    
    
    var nTitle = ""
    var nDesc = ""
    var nImage = ""
    var nLink = ""
    
    var urlString = ""
    
    var delegate: navigateNewsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitle.title = "\(nTitle)"
        newsDescription.text = "\(nDesc)"
        
        let url = NSURL(string: self.nImage)
        let imageData = NSData(contentsOf: url! as URL)
        let image = UIImage(data: imageData! as Data)
        newsImage.image = image
        urlString = nLink
        
    }
    @IBAction func imageButton(_ sender: Any) {
       /** let storyboard = UIStoryboard(name: "WebViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController //lets you move to DetailViewController
        vc?.nTitle = nTitle
        vc?.nImage = nImage
        vc?.nDesc = newsDescription.text!
        vc?.nLink = nLink
        
        vc?.delegate = self as navigateNewsDelegate
        self.navigationController?.pushViewController(vc!, animated: true)**/
        performSegue(withIdentifier: "goUrl", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goUrl"  {
            let vc = segue.destination as! WebViewController
            vc.finalUrl = urlString
            vc.backButtonName = "News Feed"
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension DetailViewController : navigateNewsDelegate {
    func navigateNews(rssitem: RSSItem) {
        self.dismiss(animated: true){
        }
    }
}
