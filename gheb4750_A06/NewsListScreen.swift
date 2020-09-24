//
//  NewsListScreen.swift
//  gheb4750_A06
//
//  Created by Delina Ghebrekristos on 2020-04-06.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//
import Foundation
import UIKit

class NewsListScreen: UITableViewController, URLSessionTaskDelegate, XMLParserDelegate {

    
    var newsIndex: Int = 0
    private var rssItems: [RSSItem]?
    let urlPath: String = "https://globalnews.ca/toronto/feed/"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: urlPath) { (rssItems) in
            
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation{
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
                
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard rssItems != nil else{
            return 0
        }
        
        return rssItems!.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController //lets you move to DetailViewController
        vc?.nTitle = rssItems![indexPath.row].title
        vc?.nImage = rssItems![indexPath.row].imageLink
        vc?.nDesc = rssItems![indexPath.row].desc
        vc?.nLink = rssItems![indexPath.row].link
        newsIndex = indexPath.row
        
        vc?.delegate = self as? navigateNewsDelegate
        self.navigationController?.pushViewController(vc!, animated: true)
        /**let vc1 = storyboard?..instantiateViewController(withIdentifier: "addViewController") as? addViewController**/

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
