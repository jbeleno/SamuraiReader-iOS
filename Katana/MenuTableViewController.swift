//
//  MenuTableViewController.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 28/02/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var section = "Esporte"
    let segueIdentifier = "SectionSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    /**
     * This method set a section name according to the selection of the user in the menu
     **/
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 1) {
            self.section = "Esportes"
        } else if (indexPath.row == 2) {
            self.section = "Política"
        } else if (indexPath.row == 3) {
            self.section = "Tecnologia"
        } else if (indexPath.row == 4) {
            self.section = "Internacional"
        } else if (indexPath.row == 5) {
            self.section = "Economia"
        } else if (indexPath.row == 6) {
            self.section = "Cotidiano"
        }
        
        self.performSegueWithIdentifier(segueIdentifier, sender: self)
    }
    
    /**
     * This method adds the section to the articles to load the right section when the user
     * select a topic in the menu
     **/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! UINavigationController
        
        if(segue.identifier == segueIdentifier){
            let view2load = navController.topViewController as! ArticlesViewController
            view2load.section = self.section
        }
    }
}
