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
    
    enum SerializationError: Error {
        case missing(String)
    }
    
    init(json: [String]) throws {
        guard let title = json["title"] as? String else { throw SerializationError.missing("Title is missing")}
        guard let author = json["author"] as? String else { throw SerializationError.missing("Author is missing")}
        guard let image = json["imageURL"] as? String else { throw SerializationError.missing("Image URL is missing")}
        
        self.title = title
        self.author = author
        self.image = image
    }
    
    static let baseURL = "https://api.myjson.com/bins/"
    
    static func getJSON(withType typeOfRequest: String, completion: @escaping ([Book]) -> ()) {
        let url = baseURL + typeOfRequest
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var bookArray: [Book] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [Any] {
                        print(json)
                        if let bookObject = try? Book(json: json) {
                            bookArray.append(bookObject)
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
