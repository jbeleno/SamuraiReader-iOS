//
//  ViewController.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 29/02/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import SWRevealViewController

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var refreshControl: UIRefreshControl!
    
    var section: String?
    var model: ArticlesModel?
    let cellIdentifier = "ArticleCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This add the toogle effect on the hamburger icon
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Setup some thing from the table
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup the refresh action
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        // This declare the default model if is not already set
        if model != nil{
            self.section = "Esportes"
            model = ArticlesModel(section: self.section!)
        }
    }
    
    /**
     * This method stop the animation of the refreshcontrol because could interfere with the
     * UIActivityIndicator animation, clear the data source to start from scratch the data
     * and populate the data source again with new data
     **/
    func refresh(sender:AnyObject)
    {
        self.refreshControl.endRefreshing()
        model?.clearDataSource(self.tableView)
        model?.populateWithDataSource(self.tableView, indicator: self.indicator, lblMessage: self.lblMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
