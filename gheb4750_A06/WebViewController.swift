//
//  WebViewController.swift
//  gheb4750_A06
//
//  Created by Delina Ghebrekristos on 2020-04-06.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var backButtonName = ""
    
    var finalUrl = ""
    var delegate: navigateNewsDelegate?
    
    let kHEADERHEIGHT : CGFloat = 44.0
    //let kHEADERHEIGHT : CGFloat = 0.0 // set it to 44.0 if you want a header
    let kFOOTERHEIGHT : CGFloat = 44.0
    
    var webView : WKWebView = WKWebView()
    var footerView : UIView = UIView()
    
    var leftArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var rightArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var listButton = UIButton(type: UIButton.ButtonType.custom)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.allowsBackForwardNavigationGestures = true
        self.view.backgroundColor = UIColor.white
        self.footerView.backgroundColor = UIColor.gray
        
        // Image set
        self.leftArrowButton.setImage(UIImage(named: "left_button"), for: [])
        // when user presses on the left arrow button, the method back is executed
        self.leftArrowButton.addTarget(self, action:#selector(back(_ : )), for: .touchUpInside)
        
        self.rightArrowButton.setImage(UIImage(named: "right_button"), for: [])
        self.rightArrowButton.addTarget(self, action:#selector(forward(_ : )), for: .touchUpInside)
        
        
        self.view.addSubview(self.webView)
        self.view.addSubview(self.footerView)
        self.view.addSubview(self.leftArrowButton)
        self.view.addSubview(self.rightArrowButton)
        
        self.webView.navigationDelegate = self as? WKNavigationDelegate
        webView.load(finalUrl)
        
    }
    @IBAction func newsFeedButton(_ sender: Any) {
        performSegue(withIdentifier: "goNewsFeed", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "goNewsFeed"  {
                _ = segue.destination as! NewsListScreen
                   
               }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillLayoutSubviews() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height
            
            
        self.webView.frame = CGRect(origin: CGPoint(x:0, y: statusBarHeight!+kHEADERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - (statusBarHeight! + kHEADERHEIGHT) - kFOOTERHEIGHT))
            
            self.footerView.frame = CGRect(origin: CGPoint(x:0, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: kFOOTERHEIGHT))
            
            self.leftArrowButton.frame = CGRect(origin: CGPoint(x:5, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
            
            
            self.rightArrowButton.frame = CGRect(origin: CGPoint(x:10 + kFOOTERHEIGHT, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
            
            self.listButton.frame = CGRect(origin: CGPoint(x:self.view.frame.size.width - 85, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: 80, height: kFOOTERHEIGHT))
        
        }
        
        // MARK: WKNavigationDelegate
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

            NSLog("Start")
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            NSLog("Failed Navigation %@", error.localizedDescription)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Finish navigation
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("Finish Navigation")
            print("Title:%@ URL:%@", webView.title!, webView.url!)
        }
        
    
        
        @objc func back(_ sender: Any) {
            if (self.webView.canGoBack) {
                self.webView.goBack()
            }
        } // back
        
        @objc func forward(_ sender: Any) {
            if (self.webView.canGoForward) {
                self.webView.goForward()
            }
        } // forward

}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}


