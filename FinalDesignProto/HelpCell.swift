//
//  HelpCell.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 02/12/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import UIKit

class HelpCell: UITableViewCell {
    
    
    @IBOutlet weak var titleHelp: UILabel!
    
    @IBOutlet weak var helpContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
