//
//  WeatherCollectionViewCell.swift
//  CloudCast
//
//  Created by shahadat on 12/1/25.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
        mainView.layer.cornerRadius =  25
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
        
    }

}
