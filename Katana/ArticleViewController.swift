//
//  ArticleViewController.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 2/03/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webContainer: UIWebView!
    
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the uppon bar inside the WebView
        self.automaticallyAdjustsScrollViewInsets = false
        
        loadPage(link!)
    }
    
    /**
     * This method loads the website inside the WebView
     **/
    func loadPage(link:String){
        let url = NSURL(string: link)
        let request = NSURLRequest(URL: url!)
        webContainer.loadRequest(request)
    }
    
    /**
     * This method start the loading animation and setup the finish of this
     **/
    func webViewDidStartLoad(webView: UIWebView) {
        indicator.startAnimating()
        indicator.hidden = false
        indicator.hidesWhenStopped = true
    }
    
    /**
     * This method set the title of the view according with the title of the page
     * and stop the indicator animation
     **/
    func webViewDidFinishLoad(webView: UIWebView) {
        self.title = webContainer.stringByEvaluatingJavaScriptFromString("document.title")
        indicator.stopAnimating()
    }
}
