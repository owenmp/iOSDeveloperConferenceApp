//
//  HelpTableViewController.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 02/12/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

class HelpTableViewController: UITableViewController {
    var sections = ["Sessions","Bookmarks","Speakers","Session Details","Speaker Profile"]
    let cellReuseIdentifier = "helpCell"
    
    var titles = [
        ["View Sessions","Check Details","Bookmark Session"],["View Bookmarks","Remove a bookmark"],["View List of Speakers","See Speaker Details"],["View Speaker","View Location"],["Follow on Twitter"]
    ]
    var help = [
        ["To see all the sessions, scroll through the table, and all the rows indicate what sessions are being held, by whom and at what time. The data is specified by the day it is grouped in","To find out more about a session, click the row and it will open the Session Details screen, from here you will be able to learn more about the session, including what it contains, who the speaker is and where it is taking place.","To bookmark a session, press the bookmark symbol on the right side of the cell, it will turn blue to indicate that the session has been bookmarked."],["Using the tab bar on the bottom, click the bookmarks tab and you will be presented with a table that shows all of your bookmarked sessions.","To remove a bookmark, press the blue bookmark symbol and you will be prompted as to whether you want to remove it, if you do, then press confirm and it will be removed from your list of bookmarks."],["To find the list of speakers, use the navigation tab to open the speakers screen, from here you will find the list of speakers at the conference.","From the speakers list, click a speaker to be taken to their profile page and you will find more details, including their bio, twitter, and the sessions they hold"],["To view more details about the speaker of a session, click their name that is in blue text, and you will be taken to their profile page where you can find out more about them.","To view a location, click the location that is in blue text, you will then be taken to Apple maps, if you then use your location settings or type in a starting location, you will then be navigated to the building the session is taking place in."],["To follow the speaker on twitter, press the 'Follow on Twitter' text and you will be taken to their Twitter webpage."] ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = titles[section]
        return rows.count
    }
    
  override func tableView(_  tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
              return 40
      }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell", for: indexPath)as!HelpCell
        let wantedTitle = titles[indexPath.section][indexPath.row]
        let wantedText = help[indexPath.section][indexPath.row]
        
        cell.titleHelp.text = wantedTitle
        cell.helpContent.text = wantedText

        // Configure the cell...

        return cell
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
