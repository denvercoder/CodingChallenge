//
//  Book.swift
//  pmChallenge
//
//  Created by Timothy Myers on 8/9/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

struct Book {
    let title: String
    let author: String
    let image: String
    
    init?(json: [String:Any]) {
        guard let title = json["title"] as? String,
            let author = json["author"] as? String,
            let image = json["imageURL"] as? String else {
                return nil
        }
        
        self.title = title
        self.author = author
        self.image = image
    }
    
}
