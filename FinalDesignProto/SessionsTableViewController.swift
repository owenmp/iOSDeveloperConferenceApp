//
//  SessionsTableViewController.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 28/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit
/**
 Class that holds the sessions table view, and displays all the sessions that are read in from the database.
 */

class SessionsTableViewController: UITableViewController {
    //Array to split up the sessions into sections based on their date.
    var Days = ["Monday","Tuesday","Wednesday","Thursday"]
   
    //Reads in all the sessions and splits them up based on the day they are on, then these will be ordered into the correct section.
    var lessons = [[DBAccess.sharedInstance.getMonday()],[DBAccess.sharedInstance.getTuesday()],[DBAccess.sharedInstance.getWednesday()],[DBAccess.sharedInstance.getThursday()]]
    
  

    
   
    
    
    
        override func viewDidLoad() {
            //let tester = DBAccess.sharedInstance.getBookmarkedSession(name: "Taming Animation")
            //print(tester)
            DBAccess.sharedInstance.bookmarkTitle()
            DBAccess.sharedInstance.getBookmarks()
         //   DBAccess.sharedInstance.getBookmarks()
        super.viewDidLoad()
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
           
            
            
            
            //DBAccess.sharedInstance.readList[]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return lessons.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        var rows = lessons[section][0]
        return rows.count
    }

    /**
     Populates the table with all the details of the sessions into rows. Uses the correct section and the indexPath to put the sessions into the correct order.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell",for: indexPath)as!SessionsCellTableViewCell
        let wantedName = lessons[indexPath.section][0][indexPath.row].title
        let wantedTime = lessons[indexPath.section][0][indexPath.row].time
        let wantedLocation = lessons [indexPath.section][0][indexPath.row].speaker
        let wantedType = lessons[indexPath.section][0][indexPath.row].sessionType
        //Populates the cell labels with values to indicate details of the session
        
        cell.lblName.text = wantedName
        cell.timeLbl.text = wantedTime
        
        if wantedLocation == "" {
            cell.speakerNameLbl.text = "No Speaker"
        } else {
        cell.speakerNameLbl.text = wantedLocation
        }
        
      
        //These are used to stop the user from being able to bookmark sessions that arent talks or workshops
        if (lessons[indexPath.section][0][indexPath.row].sessionType == "coffee"){
            //cell.bookmarkButton.isHidden = true
        } else if lessons[indexPath.section][0][indexPath.row].sessionType == "lunch"{
          //  cell.bookmarkButton.isHidden = true
        } else if lessons[indexPath.section][0][indexPath.row].sessionType == "dinner"{
          //  cell.bookmarkButton.isHidden = true
        } else if lessons[indexPath.section][0][indexPath.row].sessionType == "registration"{
          //  cell.bookmarkButton.isHidden = true
    }else {
          //  cell.bookmarkButton.isHidden = false
        }
        // Configure the cell...
      
//        var l = lessons[indexPath.section]
//
//        var Days = [[Monday],[Tuesday],[Wednesday],[Thursday]]
//
        
        return cell

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
        let deleteAction = UITableViewRowAction(style: .default, title: "Bookmark" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
        //Menu appears allowing the user to delete
            let deleteMenu = UIAlertController(title: nil, message: "Are you sure you want to bookmark \(self.lessons[indexPath.section][0][indexPath.row].title)", preferredStyle: .actionSheet)
            //deletes cell from table
            let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: {
                action in print("Bookmarked \(self.lessons[indexPath.section][0][indexPath.row])")
                
                ///// bookmark function here
                
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteMenu.addAction(confirmAction)
            deleteMenu.addAction(cancelAction)
            
            DBAccess.sharedInstance.readList.append(self.lessons[indexPath.section][0][indexPath.row].id)
            DBAccess.sharedInstance.bookmarkTitle()
            
            self.present(deleteMenu, animated: true, completion: nil)

        })
        deleteAction.backgroundColor = UIColor.blue
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
        if segue.identifier == "sessionIdentifier" {
            
            
            

            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let sessionVC = segue.destination as! SessionDetailsVC
                sessionVC.valueForName = lessons[indexPath.section][0][indexPath.row].title
                sessionVC.valueForTime = lessons[indexPath.section][0][indexPath.row].time
                sessionVC.valueForDate = lessons[indexPath.section][0][indexPath.row].sessionDate
                sessionVC.valueForType = lessons[indexPath.section][0][indexPath.row].sessionType
                sessionVC.valueForContent = lessons[indexPath.section][0][indexPath.row].content
                sessionVC.nameOfSpeaker = lessons[indexPath.section][0][indexPath.row].speaker
                sessionVC.nameOfLocation = lessons[indexPath.section][0][indexPath.row].location
                sessionVC.nameOfID = lessons[indexPath.section][0][indexPath.row].id
                
            }
        }
            
            
            
           
  
            
            

        
        
        
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

