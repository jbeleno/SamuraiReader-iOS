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
    let paramTitle = "title"
    let paramDescription = "description"
    let paramLink = "link"
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
    
    func populateWithDataSource(table:UITableView, indicator: UIActivityIndicatorView, lblMessage:UILabel){
        
        if(offset == 0){
            indicator.startAnimating()
            indicator.hidden = false
        }
        
        let parameters = [
            argOffset : offset,
            argSection : section
        ]
        
        Alamofire.request(.POST, linkArticles, parameters: parameters as! [String : AnyObject]).responseJSON{
            response in
            
            switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                
                    if let status = response.objectForKey(self.paramStatus) as? String{
                        if status == self.paramOK {
                            if let articles = response.objectForKey(self.paramArticles) as? [[String:String]]{
                                for article in articles{
                                    
                                    let title = article[self.paramTitle]
                                    let description = article[self.paramDescription]
                                    let link = article[self.paramLink]
                                    
                                }
                            }else{
                                lblMessage.text = self.internalErrorMessage
                            }
                        }else {
                            lblMessage.text = self.internalErrorMessage
                        }
                    }else {
                        lblMessage.text = self.internalErrorMessage
                    }
                case .Failure:
                    if(self.offset == 0){
                        lblMessage.text = self.errorMessage
                    }
            }
        };
    
    }
    
}