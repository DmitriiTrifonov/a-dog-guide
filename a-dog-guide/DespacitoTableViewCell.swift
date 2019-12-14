//
//  DespacitoTableViewCell.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 14.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import UIKit

class DespacitoTableViewCell: UITableViewCell {
    @IBOutlet weak var flag: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flag.text = "Jopics"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
