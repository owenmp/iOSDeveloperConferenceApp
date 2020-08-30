//
//  SpeakerCell.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 29/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

class SpeakerCell: UITableViewCell {
    
    //Outlets for the image, name and twitter @ that is displayed in the cell
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var speakerTwitterLbl: UILabel!
    @IBOutlet weak var speakerNameLbl: UILabel!
    
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        speakerImage.layer.cornerRadius = 25
//        speakerImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
