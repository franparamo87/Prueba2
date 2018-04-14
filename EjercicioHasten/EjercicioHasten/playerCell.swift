//
//  playerCell.swift
//  EjercicioHasten
//
//  Created by Francisco Paramo Muñoz on 14/4/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class playerCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
