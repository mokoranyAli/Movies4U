//
//  CustomTableViewCell.swift
//  PopularMoviesProject
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var txtRate: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
