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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let book = books[indexPath.row]
        
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        
        if let data = try? Data(contentsOf: URL(string: book.imageURL)!) {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
}
