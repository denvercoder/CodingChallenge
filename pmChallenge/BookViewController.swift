//
//  BookViewController.swift
//  pmChallenge
//
//  Created by Timothy Myers on 7/20/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import UIKit
import Foundation

class BookViewController: UITableViewController {
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Book.getJSON(withType: "books.json") { (results: [Book]?) in
            
            if let bookData = results {
                self.books = bookData
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let book = books[indexPath.row]
        
        cell.textLabel?.text = book["title"]

        return cell
    }


 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }

}
