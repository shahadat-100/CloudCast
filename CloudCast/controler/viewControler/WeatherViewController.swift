//
//  WeatherViewController.swift
//  CloudCast
//
//  Created by shahadat on 12/1/25.
//

import UIKit



class WeatherViewController: UIViewController {
    
    let majorCities = [
        // North America
//        "New York", "Los Angeles",// "Chicago", "Houston", "Phoenix",
//        //"Toronto", "Vancouver", "Montreal", "Mexico City", "Guadalajara",
//
//        // South America
//        "São Paulo", "Buenos Aires",// "Rio de Janeiro", "Lima", "Bogotá",
//       // "Santiago", "Caracas", "Quito", "La Paz", "Montevideo",
//
//        // Europe
//        "London", "Paris", "Berlin",// "Rome", "Madrid", "Vienna",
//        //"Amsterdam", "Brussels", "Stockholm", "Warsaw",
//       // "Lisbon", "Dublin", "Prague", "Budapest", "Zurich",
//
//        // Africa
//        "Cairo", "Lagos", "Johannesburg", //"Nairobi", "Algiers",
//        //"Casablanca", "Accra", "Addis Ababa", "Tunis", "Cape Town",
//
//        // Asia
//        "Tokyo", "Beijing",// "Shanghai", "Mumbai", "Delhi",
//        //"Bangkok", "Seoul", "Singapore", "Jakarta", "Kuala Lumpur",
//       // "Manila", "Hong Kong", "Dubai", "Riyadh", "Tehran",
//       // "Baghdad", "Karachi", "Istanbul", "Dhaka", "Hanoi",
//
//        // Oceania
//        "Sydney",// "Melbourne", "Auckland", "Brisbane", "Perth",
        //"Adelaide", "Wellington", "Christchurch", "Gold Coast", "Canberra",

        // Middle East
       // "Tel Aviv", "Jerusalem", "Doha", "Abu Dhabi", "Muscat",
        "Jeddah", //"Kuwait City", "Amman", "Beirut", "Damascus",

        // Central Asia
        "Tashkent",// "Almaty", "Bishkek", "Dushanbe", "Ashgabat",

        // Others
        "Moscow",// "Saint Petersburg", "Helsinki", "Oslo", "Reykjavik"
    ]
    
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var probabilityLbl: UILabel!
    @IBOutlet weak var hiLowLbl: UILabel!
    
    @IBOutlet weak var cnstLeftViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cnstRightViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var weeklyForecastCollectionView: UICollectionView!
    @IBOutlet weak var hourlyForecastCollectionVIew: UICollectionView!
    
    var screenWeidth = UIScreen.main.bounds.width
    
    var viewModelUser = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelUser.fetchWeatherData(for: majorCities )
        
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
