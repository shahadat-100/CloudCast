//
//  WeatherViewController.swift
//  CloudCast
//
//  Created by shahadat on 12/1/25.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var probabilityLbl: UILabel!
    @IBOutlet weak var hiLowLbl: UILabel!
    
    @IBOutlet weak var cnstLeftViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cnstRightViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var weeklyForecastCollectionView: UICollectionView!
    @IBOutlet weak var hourlyForecastCollectionVIew: UICollectionView!
    
    var screenWeidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.weeklyForecastCollectionView.dataSource = self
        self.weeklyForecastCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        self.weeklyForecastCollectionView.setCollectionViewLayout(layout, animated: true)

        self.weeklyForecastCollectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
  
    }
    
    @IBAction func hourlyWeatherButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3)
        {
            self.cnstLeftViewLeading.constant = 0
            self.cnstRightViewLeading.constant = self.screenWeidth
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func weeklyWeatherButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3)
        {
            self.cnstRightViewLeading.constant = -self.screenWeidth
            self.cnstLeftViewLeading.constant = -self.screenWeidth
            self.view.layoutIfNeeded()
        }
    }
}


extension WeatherViewController:UICollectionViewDelegate
{
    
}

extension WeatherViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weeklyForecastCollectionView
        {
            guard let collectionViewCell = self.weeklyForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else
            {
                return UICollectionViewCell()
                
            }
            return collectionViewCell

        }
        return UICollectionViewCell()
        
    }
}


extension WeatherViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: weeklyForecastCollectionView.frame.width / 6, height: weeklyForecastCollectionView.frame.height - 40)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return  UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
    }
    
}
