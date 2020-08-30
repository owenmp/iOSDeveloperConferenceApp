//
//  SessionDetailsVC.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 05/11/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

/**
 This class holds all the variables and functions for the SessionDetails View controller, where the user can find more details about the session.
 */

class SessionDetailsVC: UIViewController {
    
    //This is a struct holding all the details about a session which can be written to the file store
    struct sessionToSave: Codable {
        var name: String
        var content: String
        var speakerName: String
        var locationName: String
        var date: String
        var type: String
    }
    //These values make up what is displayed in the labels, values are passed into them using the segue from the sessions table view controller
    var valueForName = ""
    var valueForContent = ""
    var valueForDate = ""
    var valueForTime = ""
    var valueForType = ""
    var nameOfLocation = ""
    var nameOfSpeaker = ""
    var nameOfID = ""
    var bookmarked = false
    
    var isBookmarked = false
    //Button that is apart of the navigation bar that allows the user to bookmark a session
    @IBOutlet weak var bookmarkBtn: UIBarButtonItem!
    
    
    /**
            Declarations for all of the labels and buttons that are displayed on the session details view controller
     */
    @IBOutlet weak var locationSpeakerTable: UITableView!
    @IBOutlet weak var rowDetails: UITableView!
    @IBOutlet weak var sessionNameLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var sessionTypeLbl: UILabel!
    @IBOutlet weak var speakerLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!

    @IBOutlet weak var titleBackgroundView: UILabel!
    
    
   // @IBOutlet weak var titleView: UIView!
    
    
    //Executes the function to bookmark a session when the button is pressed
    @IBAction func bookmarkBtn(_ sender: Any) {
        if !isBookmarked {
        let alert = UIAlertController(title: "Bookmark Session", message: "Are you sure you want to bookmark this session", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in DBAccess.sharedInstance.readList.append(self.nameOfID)
        DBAccess.sharedInstance.bookmarkTitle()
            self.bookmarkBtn.title = "Remove Bookmark"
            self.isBookmarked = true
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
//            bookmarkBtn.title = "Remove Bookmark"
        
        } else {
            
            let alert = UIAlertController(title: "Bookmark Session", message: "Are you sure you want to remove the bookmark of this session", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in DBAccess.sharedInstance.removeBookmark(name: self.nameOfID)
                print("Remove")
                self.bookmarkBtn.title = "Bookmark"
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    //This is used to bookmark sessions.
    func encodeData() {
        let name = sessionNameLbl.text!
        //details of the session that is to be saved
        let bookmarkedSession = sessionToSave(name: name, content: valueForContent, speakerName: nameOfSpeaker,locationName: nameOfLocation,date: valueForDate,type: valueForType)
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first!
        //where the details will be saved
        let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
        let property = PropertyListEncoder()
        let encodedVersion = try? property.encode(bookmarkedSession)
        try? encodedVersion?.write(to: archiveURL, options: .noFileProtection)
      //  print(encodedVersion)
        
    }
    
  
    
   
    
    /**
        Function to decode the data of the session that had been bookmarked. Accesses the file that has been written to and  prints the strings that are saved.
     */
    func decodeData(){
        let propertyListDecoder = PropertyListDecoder()
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in:
                .userDomainMask).first!
       let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
        if let retrievedSessionData = try? Data(contentsOf: archiveURL), let decodedSession = try? propertyListDecoder.decode(sessionToSave.self, from: retrievedSessionData){
            print(decodedSession)
        }
    }
    
    
    //Function that when pressed, takes the user to the speaker profile view controller and displays the correct details of the speaker who holds this session
    @IBAction func speakerButton(_ sender: Any) {
        let speakerID = speakerButton.titleLabel?.text
        let speaker = DBAccess.sharedInstance.getSpecificSpeaker(speaker: nameOfSpeaker)
       // print(speaker.name)
        
        
        
    }
    //When this button is pressed, it will open apple maps with the coordinates of the location.
    @IBAction func locationButton(_ sender: Any) {
        //Retrieves the coordinates of the location based on the name of it
        let coords = DBAccess.sharedInstance.getCoOrds(location: nameOfLocation)
        let long = coords[0]
        let lat = coords[1]
        //Opens apple maps passing in the coordinates that have been retrieved from the database
         let url = "http://maps.apple.com/maps?saddr=\(long),\(lat)"
            UIApplication.shared.openURL(URL(string:url)!)
    }
   
    
    override func viewDidLoad() {
        
        //All the labels and buttons will have the correct values that have been passed through the segue from the sessions table view controller.
        speakerButton.setTitle(nameOfSpeaker, for: .normal)
        locationButton.setTitle(nameOfLocation, for: .normal)
        sessionNameLbl.text = valueForName
        contentLbl.text = valueForContent
        dateLbl.text = valueForDate
        timeLbl.text = valueForTime
        sessionTypeLbl.text = valueForType
        super.viewDidLoad()
        
        isBookmarked = DBAccess.sharedInstance.searchIfBookmarkExists(name: nameOfID)
        print(isBookmarked)
        
        if isBookmarked {
            bookmarkBtn.title = "Remove Bookmark"
        }
        
//               titleBackgroundView.layer.backgroundColor = UIColor.systemGray6.cgColor
//        titleBackgroundView.layer.cornerRadius = 20
//        titleBackgroundView.layer.masksToBounds = false
//        titleBackgroundView.layer.borderWidth = 5
        
        
//        titleView.layer.cornerRadius = 10
//        titleView.layer.masksToBounds = false
//        titleView.layer.shadowOffset = .zero
//        titleView.layer.shadowColor = UIColor.black.cgColor
//
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /**
     Function that will allow data from this class to be passed into another. In this case, the details of the speaker will be passed into the speaker profile view controller.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpeaker"{
            //Retrieves all the details of the speaker of this session.
            let speaker = DBAccess.sharedInstance.getSpecificSpeaker(speaker: nameOfSpeaker)
            
            
          
            //Assigns the values for the speaker in speaker profile
            let speakerVC = segue.destination as! SpeakerProfile
            speakerVC.valueForName = speaker.name
            speakerVC.valueForBio = speaker.bio
            speakerVC.valueForImage = speaker.photo + ".jpg"
            speakerVC.valueForTwitter = speaker.twitter
            
            
            
    }
            
        }
    }
            
        
        
        
        
        
        
    


