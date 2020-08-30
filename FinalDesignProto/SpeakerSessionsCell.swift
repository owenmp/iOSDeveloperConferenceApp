//
//  SpeakerSessionsCell.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 27/11/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

/**
 This is a table view cell, found in the table view of the speaker profile, which shows the sessions that a speaker holds.
 */
import UIKit

class SpeakerSessionsCell: UITableViewCell {
    //Label that shows the name of title of the session
    @IBOutlet weak var sessionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
