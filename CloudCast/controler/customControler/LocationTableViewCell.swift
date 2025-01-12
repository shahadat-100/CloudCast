//
//  LocationTableViewCell.swift
//  CloudCast
//
//  Created by shahadat on 11/1/25.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherDegreelbl: UILabel!
    @IBOutlet weak var hilowLbl: UILabel!
    @IBOutlet weak var loactionLbl: UILabel!
    @IBOutlet weak var probabilityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
