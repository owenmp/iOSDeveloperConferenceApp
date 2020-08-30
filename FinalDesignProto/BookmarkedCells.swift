//
//  BookmarkedCells.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 28/10/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

class BookmarkedCells: UITableViewCell {

    
    //Outlets for the name, location and time of the bookmarked session
    @IBOutlet weak var bookmarkNameLbl: UILabel!
    
    @IBOutlet weak var speakerNameLbl: UILabel!
    
    @IBOutlet weak var bookmarkTimeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
