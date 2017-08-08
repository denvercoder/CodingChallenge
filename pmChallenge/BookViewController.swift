//
//  BookViewController.swift
//  pmChallenge
//
//  Created by Timothy Myers on 7/20/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import UIKit
import Foundation

/*
struct Book {
    let title: String
    let author: String
    let imageURL: String
}
 
 */

class BookViewController: UITableViewController {
    
    var books = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func fetchJSON() {
        let urlString = "https://de-coding-test.s3.amazonaws.com/books.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                if json != nil {
                    parse(json: json)
                    return
                }
            }
        }
        DispatchQueue.main.async {
            self.displayError()
        }
    }
    
    func parse(json: JSON) {
        for result in json[].arrayValue {
            let title = result["title"].stringValue
            let author = result["author"].stringValue
            let imageURL = result["imageURL"].stringValue
            
            let obj = ["title": title, "author": author, "imageURL": imageURL]
            
            books.append(obj)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError() {
        let ac = UIAlertController(title: "Loading Error", message: "Json could not be loaded", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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
}

/*

extension Book {
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let author = json["author"] as? String,
            let imageURL = json["imageURL"] as? String
            
            else {
                return nil
        }
        
        self.title = title
        self.author = author
        self.imageURL = imageURL
        
    }
}
*/


/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

