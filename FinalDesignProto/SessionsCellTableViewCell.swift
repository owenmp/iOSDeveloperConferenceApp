//
//  SessionsCellTableViewCell.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 28/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

class SessionsCellTableViewCell: UITableViewCell {

    
    //Outlets for the button, name, speaker and time that is displayed in the cell
//    @IBOutlet weak var bookmarkButton: UIButton!

    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var speakerNameLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        
       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
