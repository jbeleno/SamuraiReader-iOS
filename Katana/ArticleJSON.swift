//
//  ArticleJSON.swift
//  Katana
//
//  Created by Juan Beleño Díaz on 1/03/16.
//  Copyright © 2016 Juan Beleño Díaz. All rights reserved.
//

import Gloss

struct ArticuloJSON:Decodable {
    let title:String?
    let description:String?
    let link:String?
    
    init?(json: JSON) {
        title = "title" <~~ json
        description = "description" <~~ json
        link = "link" <~~ json
    }
    
}