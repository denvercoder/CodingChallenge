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
    let imageURL: String
    
    enum SerializationError: Error {
        case missing(String)
    }
    
    init(json: [String:Any]) throws {
        if let title = json["title"] as? String
        {
            self.title = title
        } else {
            self.title = ""
        }
        if let author = json["author"] as? String
        {
            self.author = author
        } else {
            self.author = ""
        }
        if let imageURL = json["imageURL"] as? String
        {
            self.imageURL = imageURL
        } else {
            self.imageURL = ""
        }
        
    }
    
    static let baseURL = "https://de-coding-test.s3.amazonaws.com/"
    
    static func getJSON(withType typeOfRequest: String, completion: @escaping ([Book]) -> ()) {
        let url = baseURL + typeOfRequest
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var bookArray: [Book] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                        
                        for item in json{
                            try bookArray.append(Book.init(json: item))
                        }
                        
                    }
                } catch {
                    print("Problem parsing JSON: \(error)")
                }
                
                completion(bookArray)
            }
        }
        task.resume()
    }
    
}
