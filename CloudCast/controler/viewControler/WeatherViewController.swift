//
//  WeatherViewController.swift
//  CloudCast
//
//  Created by shahadat on 12/1/25.
//

import UIKit



class WeatherViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var cnstLeftViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cnstRightViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var weeklyForecastCollectionView: UICollectionView!
    @IBOutlet weak var hourlyForecastCollectionVIew: UICollectionView!
    
    var screenWeidth = UIScreen.main.bounds.width
    
    var city = "Dhaka"
    var viewModelWeather = WeatherViewModel()
    var weatherData: customWeatherModelforCity!
    var hourlyForecastData: customDayForecastModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeatherDataFetch()
        hourlyForecastDataFetch()
        
     
        self.weeklyForecastCollectionView.dataSource = self
        self.weeklyForecastCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        self.weeklyForecastCollectionView.setCollectionViewLayout(layout, animated: true)

        self.weeklyForecastCollectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        
        
        self.hourlyForecastCollectionVIew.delegate = self
        self.hourlyForecastCollectionVIew.dataSource = self
        let layout1 = UICollectionViewFlowLayout.init()
        layout1.scrollDirection = .horizontal
        self.hourlyForecastCollectionVIew.setCollectionViewLayout(layout1, animated: true)
        self.hourlyForecastCollectionVIew.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
  
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
    
    private func currentWeatherDataFetch()
    {
        viewModelWeather.fetchWeatherDataForCity(city: city) { _weatherData in
            
            guard let _weatherData = _weatherData else { return }
            self.weatherData = _weatherData
            
            DispatchQueue.main.async {
                
                self.temperatureLabel.text = self.weatherData._Temperature
                self.cityLabel.text = self.weatherData._Location
                self.humidityLabel.text = self.weatherData._Humidity
                self.windSpeedLabel.text = self.weatherData._WindSpeed
                self.conditionLabel.text = self.weatherData._Condition
                
            }
            
        }
    
    }
    
    private func hourlyForecastDataFetch()
    {
       // viewModelWeather.tryApi(city: city)
        
//        print("ddddddda")
//        viewModelWeather.fetchHourlyForecast(for: city) { HourlyforescastData in
//            
//            print("hhh")
//            guard let HourlyforescastData = HourlyforescastData else {
//                print("nillllslsllslld")
//                return }
//            self.hourlyForecastData = HourlyforescastData
//            
//            self.hourlyForecastCollectionVIew.reloadData()
//            print(HourlyforescastData)
//            print("hi")
//      
//        }
    }
    
}


extension WeatherViewController:UICollectionViewDelegate
{
    
}

extension WeatherViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weeklyForecastCollectionView
        {
            return 12
        }
        else if collectionView == hourlyForecastCollectionVIew
        {
            return hourlyForecastData?._temperature.count ?? 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weeklyForecastCollectionView
        {
            guard let collectionViewCell = self.weeklyForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else
            {
                return UICollectionViewCell()
                
            }
            if indexPath.row % 2 == 0
            {
                collectionViewCell.weatherImageView.image = UIImage(named: "Snow")
            }else
            {
                collectionViewCell.weatherImageView.image = UIImage(named: "Thunderstorm")
            }
            return collectionViewCell

        }
        else if collectionView == hourlyForecastCollectionVIew
        {
            guard let collectionViewCell = self.hourlyForecastCollectionVIew.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else
            {
                return UICollectionViewCell()
            }
            
//            collectionViewCell.Time_Label.text = hourlyForecastData?._time[indexPath.row]
//            collectionViewCell.temperatureLabel.text = hourlyForecastData?._temperature[indexPath.row]
//            
//            if hourlyForecastData?._condition[indexPath.row] == "Clear"
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "Clear")
//            }
//            else if hourlyForecastData?._condition[indexPath.row] == "Cloudy"
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "Cloudy_")
//            }
//            else if hourlyForecastData?._condition[indexPath.row] == "Fog"
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "Fog")
//            }
//            else if hourlyForecastData?._condition[indexPath.row] == "Rain"
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "Rain")
//                
//            }else if hourlyForecastData?._condition[indexPath.row] == "Snow"
//            {
//                
//                collectionViewCell.weatherImageView.image = UIImage(named: "Snow")
//            }
//            else if hourlyForecastData?._condition[indexPath.row] == "Thunderstorm"
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "Thunderstorm")
//            }
//            else
//            {
//                collectionViewCell.weatherImageView.image = UIImage(named: "tornado")
//            }
            
            if indexPath.row % 2 == 0
            {
                collectionViewCell.weatherImageView.image = UIImage(named: "Cloudy_")
            }else {
                collectionViewCell.weatherImageView.image = UIImage(named: "Rain")
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
