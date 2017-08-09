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
    
    init?(json: [String:Any]) throws {
        guard let title = json["title"] as? String,
            let author = json["author"] as? String,
            let image = json["imageURL"] as? String else {
                return nil
        }
        
        self.title = title
        self.author = author
        self.image = image
    }
    
    static let url = "https://de-coding-test.s3.amazonaws.com/books.json"
    
    static func getJSON(completion: @escaping ([Book]) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var bookArray: [Book] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let bookObject = try? Book(json: json) {
                            bookArray.append(bookObject!)
                        }
                        
                    }
                } catch {
                    print("Problem parsing JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
