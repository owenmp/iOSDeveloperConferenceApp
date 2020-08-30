//
//  SpeakerProfile.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 04/11/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit


/**
 This is the class to show all the individual details of a speaker. It is passed in values from the speaker table view segue,
    and shows all the fields from the speaker table.
 */
class SpeakerProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //These labels hold the name and bio
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    //This holds the profile picture of the speaker
    @IBOutlet weak var speakerImage: UIImageView!
    //This populates the table that holds the sessions that the speaker
    let cellReuseIdentifier = "speakerSessionCell"
    
   
    //These values populate all the labels in the view controller
    var valueForName = ""
    var valueForBio = ""
    var valueForImage = ""
    var valueForTwitter = ""
    var valueForID = ""
    var valueForTwitterAcc = "www.twitter.com/"
   // var valueForSession: String = ""
    //This table view holds the sessions that the speaker holds.
    @IBOutlet var tableView: UITableView!
    var sessions: [String] = []

    @IBOutlet weak var frameImage: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var twitterButton: UIButton!
    //When the twitter button is pressed, it opens the speakers twitter profile using safari
    @IBAction func twitterButton(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "http://www.twitter.com/" + valueForTwitter)! as URL)
    }
    
   
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Sets the labels and image to the values that are passed through the segue
        nameLbl.text = valueForName
        bioLbl.text = valueForBio
        speakerImage.image = UIImage(named: valueForImage + ".jpg")
        tableView.delegate = self
        tableView.dataSource = self
        sessions = DBAccess.sharedInstance.getSpeakersSessions(speaker: valueForImage)
        print(sessions)
        //coverImage.layer.cornerRadius = 20
        //coverImage.layer.masksToBounds = true
        frameImage.layer.cornerRadius = 25
        frameImage.layer.masksToBounds = true
        speakerImage.layer.cornerRadius = 25
        speakerImage.layer.masksToBounds = true
        speakerImage.layer.borderWidth = 5
        speakerImage.layer.borderColor = UIColor.white.cgColor
        self.title = valueForName
        valueForTwitterAcc += valueForTwitter
        twitterButton.setTitle(valueForTwitterAcc, for: .normal)
        
//        sessions = sessions.filter { $0 != "Registration"}
//        sessions = sessions.filter { $0 != "Optional Social"}
//        sessions = sessions.filter { $0 != "Coffee Break"}
//        sessions = sessions.filter { $0 != "Conference Dinner"}
//        sessions = sessions.filter { $0 != "Lunch"}
        print(valueForID)
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Speaker's Sessions"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
       }
   // Sepcifies how many rows there needs to be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SpeakerSessionsCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SpeakerSessionsCell
        //let sessions = DBAccess.sharedInstance.getSpeakersSessions(speaker: valueForImage)
        //All the speakers only have one session that they hold, so it only needs to take the first item of the array
   // cell.sessionName.text = sessions[0]
        
        let wantedName = sessions[indexPath.row]
        cell.sessionName.text = wantedName
        
    return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                        return 40
                }


}
