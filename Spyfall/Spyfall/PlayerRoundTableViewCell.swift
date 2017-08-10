//
//  PlayerRoundTableViewCell.swift
//  Spyfall
//
//  Created by Daniel Meechan on 09/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class PlayerRoundTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var nameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
