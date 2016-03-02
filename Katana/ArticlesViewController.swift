//
//  ViewController.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 29/02/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import UIKit
import SWRevealViewController
import Gloss

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var refreshControl: UIRefreshControl!
    
    var section = "Esportes"
    var model = ArticlesModel(section: "Esportes")
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
        
        // Load data for first time
        model.populateWithDataSource(self.tableView, indicator: indicator, lblMessage: lblMessage)
    }
    
    /**
     * This method stop the animation of the refreshcontrol because could interfere with the
     * UIActivityIndicator animation, clear the data source to start from scratch the data
     * and populate the data source again with new data
     **/
    func refresh(sender:AnyObject)
    {
        self.refreshControl.endRefreshing()
        model.clearDataSource(self.tableView)
        model.populateWithDataSource(self.tableView, indicator: self.indicator, lblMessage: self.lblMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * I'm going to use just a section with a big amount of cells in it
     **/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * The number of rows in the section is determined by number of articles in the datasource
     **/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.model.datasource.count)
    }
    
    /**
     * Setting up the cell to be shown according to the position
     **/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // If swift load the last row is because the user scrolls down until reach
        // the bottom, then the app needs to load more info
        if indexPath.row == (model.datasource.count - 1){
            model.populateWithDataSource(self.tableView, indicator: indicator, lblMessage: lblMessage)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArticleTableViewCell
        
        // Configure the cell
        let ArticleItem = self.model.datasource.objectAtIndex(indexPath.row) as! JSON
        let Article = ArticuloJSON(json: ArticleItem)
        
        cell.title.text = Article?.title
        cell.mdescription.text = Article?.description
        cell.journal.text = Article?.journal
        
        return cell
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
