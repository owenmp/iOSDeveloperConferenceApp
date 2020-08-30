//
//  BookmarkedTableViewController.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 28/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit
/**
 Class to display all the bookmarked sessions,  takes in decoded values to populate the table view.
 */

class BookmarkedTableViewController: UITableViewController {
    
    
    
    var start = DBAccess.sharedInstance.readList
    var favourites: [session] = []
   
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBAction func refreshList(_ sender: Any) {
        DBAccess.sharedInstance.getBookmarks()
    }
    
    //Array that seperates the sessions into days.
   var Days = ["Sessions"]
    //Holds the values that are read in from the list file
   
       
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        start = DBAccess.sharedInstance.readList
       favourites = DBAccess.sharedInstance.getBookmarkedSession(name: start)
        //super.viewWillAppear()
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
          favourites = DBAccess.sharedInstance.getBookmarkedSession(name: start)
      
            super.viewDidLoad()
       

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    
    override func viewDidAppear(_ animated: Bool) {
        DBAccess.sharedInstance.getBookmarks()
        start = DBAccess.sharedInstance.readList
        favourites = DBAccess.sharedInstance.getBookmarkedSession(name: start)
        self.tableView.reloadData()
        print("It appeared")
    }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            
            //var rowsnumber = bookmarks[section][0]
            //return rowsnumber.count
           // var rowNumber = bookmarks[section][0]
            return favourites.count
            // return rowNumber.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkedCell",for: indexPath)as!BookmarkedCells
           
            
            let wantedName = favourites[indexPath.row].title
            let wantedSpeaker = favourites[indexPath.row].speaker
            let wantedTime = favourites[indexPath.row].time
            
            
            cell.bookmarkNameLbl.text = wantedName
            cell.bookmarkTimeLbl.text = wantedTime
           // cell.speakerNameLbl.text = wantedSpeaker
            
            if wantedSpeaker == "" {
                cell.speakerNameLbl.text = "No Speaker"
            } else {
            cell.speakerNameLbl.text = wantedSpeaker
            }
            
            print(wantedName)
            
         // let detailsBookmark = DBAccess.sharedInstance.getBookmarkedSession(name: wantedName)
                return cell
            
          //  cell.speakerNameLbl.text = detailsBookmark.speaker
           // cell.bookmarkTimeLbl.text = detailsBookmark.time

            
            
            
            
            
            // Configure the cell...

            

           
        }
        
        
        override func tableView(_  tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return Days[section]
        }
            
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 40
        }
            
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
        }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
       {
           
           //Delete action when the cell is swiped
           let deleteAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
           //Menu appears allowing the user to delete
            let deleteMenu = UIAlertController(title: nil, message: "Are you sure you want to  remove bookmark '\(self.favourites[indexPath.row])'", preferredStyle: .actionSheet)
               //deletes cell from table
               let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: {
                   action in print("Removed \(self.favourites[indexPath.row])")
                   
                   //delete row here
                print("delete")
                //self.tableView.deleteRows(at: [indexPath], with: .automatic)
                let a = self.favourites[indexPath.row]
                self.favourites.remove(at: indexPath.row)
                DBAccess.sharedInstance.readList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                DBAccess.sharedInstance.bookmarkTitle()
                
               // DBAccess.sharedInstance.readList.encode(to: <#T##Encoder#>)
                
                   
                   
               })
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               deleteMenu.addAction(confirmAction)
               deleteMenu.addAction(cancelAction)
               
            
            //DBAccess.sharedInstance.readList.remove(at: <#T##Int#>) self.favourites[indexPath.row].id}
            //DBAccess.sharedInstance.readList.append(self.lessons[indexPath.section][0][indexPath.row].id)
            
            
          //  DBAccess.sharedInstance.readList.remove(at: self.favourites[indexPath.section][0][indexPath.row])
           // var fav = self.favourites[indexPath.row]
            
           // DBAccess.sharedInstance.readList.remove(at: fav)
            
               DBAccess.sharedInstance.bookmarkTitle()
            
               self.present(deleteMenu, animated: true, completion: nil)

           })
           deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
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

        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "sessionDetails" {
             if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let sessionVC = segue.destination as! SessionDetailsVC
                
                var name = favourites[indexPath.row].title
                
                sessionVC.valueForName = favourites[indexPath.row].title
                sessionVC.valueForTime = favourites[indexPath.row].time
                sessionVC.valueForDate = favourites[indexPath.row].sessionDate
                sessionVC.valueForType = favourites[indexPath.row].sessionType
                sessionVC.valueForContent = favourites[indexPath.row].content
                sessionVC.nameOfSpeaker = favourites[indexPath.row].speaker
                sessionVC.nameOfLocation = favourites[indexPath.row].location
                sessionVC.nameOfID = favourites[indexPath.row].id
                
                
                
                //var bookmark = DBAccess.sharedInstance.getBookmarkDetails(name: name)

//                sessionVC.valueForName = bookmark.title
//                sessionVC.valueForType = bookmark.sessionType
//                sessionVC.valueForDate = bookmark.sessionDate
             
        }
        //*/

    }

}

}
