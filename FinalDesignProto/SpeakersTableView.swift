//
//  SpeakersTableView.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 29/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

/**
 Class that displays all of the speakers in a table view.
 */

class SpeakersTableView: UITableViewController, UISearchResultsUpdating {
    
   
   
    
    @IBOutlet var SpeakerTableView: UITableView!
    //All the speakers are held in this value
    var speakerRows = DBAccess.sharedInstance.getSpeakers()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
  var filteredSpeakers: [speakers] = []
   
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Speakers"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
       
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
            
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredSpeakers.count
        } else {
            
            return speakerRows.count
        }
        
        
        
    }

    /**
        Creates cells based on the list of speakers that is read in, used resuseable cell to create as many as needed and populates them with the name of the speaker and their image.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakers", for: indexPath)as!SpeakerCell

       var speaker: speakers
        // Configure the cell...
        if isFiltering {
            speaker = filteredSpeakers[indexPath.row]
//        let wantedId = speakerRows[indexPath.row].photo
//        let wantedName = speakerRows[indexPath.row].name
//        let twitterText = speakerRows[indexPath.row].twitter
//        let bio = speakerRows[indexPath.row].bio
//        cell.speakerNameLbl.text = wantedName
//        cell.speakerTwitterLbl.text = twitterText
//        cell.speakerImage.image = UIImage(named: "\(wantedId).jpg")
        
        } else {
            speaker = speakerRows[indexPath.row]

        
        }
        let wantedId = speaker.photo
        let wantedName = speaker.name
        let twitterText = speaker.twitter
        let bio = speaker.bio
        cell.speakerNameLbl.text = wantedName
        cell.speakerTwitterLbl.text = twitterText
        cell.speakerImage.image = UIImage(named:"\(wantedId).jpg")
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
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
    /**
        This function is used so that when a row is clicked, it will open the speaker profile, and the data of the speaker that is clicked will be passed in.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            
            let speakerVC = segue.destination as! SpeakerProfile
            
            if isFiltering {
            speakerVC.valueForName =  filteredSpeakers[indexPath.row].name
            speakerVC.valueForBio = filteredSpeakers[indexPath.row].bio
            speakerVC.valueForImage = filteredSpeakers[indexPath.row].photo
            speakerVC.valueForTwitter = filteredSpeakers[indexPath.row].twitter
            } else {
                speakerVC.valueForName =  speakerRows[indexPath.row].name
                speakerVC.valueForBio = speakerRows[indexPath.row].bio
                speakerVC.valueForImage = speakerRows[indexPath.row].photo
                speakerVC.valueForTwitter = speakerRows[indexPath.row].twitter
            }
            
            //speakerVC.valueForID = speakerRows[indexPath.row].id
            
        }

        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
    
    
    func filterContentForSearchText(_ searchText: String,
                                    category: speakers? = nil) {
      filteredSpeakers = speakerRows.filter { (candy: speakers) -> Bool in
        return candy.name.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }
    
}

extension SpeakersTableView {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
