//
//  BreedTableViewCell.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 16.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var breedImge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        //
    }
    
}
