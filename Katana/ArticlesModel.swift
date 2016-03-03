//
//  ArticlesModel.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 29/02/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ArticlesModel {
    let paramOK = "OK"
    let paramStatus = "status"
    let paramArticles = "articles"
    let argOffset = "offset"
    let argSection = "tag"
    let linkArticles = "http://nodejs-jbeleno.rhcloud.com/articles/list"
    let errorMessage = "Por favor, verifique sua conexão com a internet"
    let internalErrorMessage = "Estamos tendo alguns problemas em nossos servidores, tente de novo em alguns minutinhos"
    
    
    var offset = 0;
    var datasource = NSMutableArray()
    var section:String
    
    init(section:String){
        self.section = section
    }
    
    /**
     * This method retrieve the datasource of articles
     **/
    func getDataSource() -> NSMutableArray{
        return datasource
    }
    
    /**
     * This method is used to fill the datasource with the articles loaded from the
     * server, also is animated the indicator and the label of error is shown when
     * exist an error
     **/
    func populateWithDataSource(table:UITableView, indicator: UIActivityIndicatorView, lblMessage:UILabel){
        
        lblMessage.hidden = true
        
        if(offset == 0){
            indicator.startAnimating()
            indicator.hidden = false
            indicator.hidesWhenStopped = true
        }
        
        let parameters = [
            argOffset : offset,
            argSection : section
        ]
        
        Alamofire.request(.POST, linkArticles, parameters: parameters as? [String : AnyObject], encoding: .JSON).responseJSON{
            response in
            switch response.result {
                case .Success(let JSON):
                    indicator.stopAnimating()
                    
                    let response = JSON as! NSDictionary
                
                    if let status = response.objectForKey(self.paramStatus) as? String{
                        if status == self.paramOK {
                            
                            let articles = response.objectForKey(self.paramArticles) as! NSArray
                                
                            for article in articles{
                                self.datasource.addObject(article)
                            }
                                
                            self.offset++
                            table.reloadData()
                        }else {
                            if(self.offset == 0){
                                lblMessage.hidden = false
                                lblMessage.text = self.errorMessage
                            }
                        }
                    }else {
                        if(self.offset == 0){
                            lblMessage.hidden = false
                            lblMessage.text = self.errorMessage
                        }
                    }
                case .Failure:
                    indicator.stopAnimating()
                    if(self.offset == 0){
                        lblMessage.hidden = false
                        lblMessage.text = self.errorMessage
                    }
            }
        };
    
    }
    
    /**
     * This method clean the datasource and reload the tableView to start from scrach
     **/
    func clearDataSource(table:UITableView){
        self.offset = 0
        datasource.removeAllObjects()
        table.reloadData()
    }
    
}