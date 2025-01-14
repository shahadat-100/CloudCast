//
//  LocationViewController.swift
//  CloudCast
//
//  Created by shahadat on 11/1/25.
//

import UIKit

class LocationViewController: UIViewController {

    
    let majorCities = [
        "Abu Dhabi", "Accra", "Addis Ababa", "Adelaide", "Algiers", "Almaty", "Amman", "Amsterdam", "Ashgabat","Auckland",
        "Baghdad", "Bangkok", "Beijing", "Beirut", "Berlin", "Bishkek", "Bogotá", "Brisbane", "Brussels", "Budapest",
        "Buenos Aires", "Cairo", "Canberra", "Cape Town", "Caracas", "Casablanca", "Chicago", "Christchurch", "Damascus",
        "Delhi", "Dhaka", "Doha", "Dubai", "Dublin", "Dushanbe", "Gold Coast", "Guadalajara", "Hanoi", "Helsinki",
        "Hong Kong", "Houston", "Istanbul", "Jakarta", "Jeddah", "Jerusalem", "Johannesburg", "Karachi", "Kuala Lumpur",
        "Kuwait City", "La Paz", "Lagos", "Lima", "Lisbon", "London", "Los Angeles", "Madrid", "Manila", "Melbourne",
        "Mexico City", "Montevideo", "Montreal", "Moscow", "Mumbai", "Muscat", "Nairobi", "New York", "Oslo", "Paris",
        "Perth", "Phoenix", "Prague", "Quito", "Reykjavik", "Rio de Janeiro", "Riyadh", "Rome", "Saint Petersburg",
        "Santiago", "Seoul", "Shanghai", "Singapore", "Stockholm", "Sydney", "São Paulo", "Tashkent", "Tehran","Tel Aviv",
        "Tokyo", "Toronto", "Tunis", "Vancouver", "Vienna", "Warsaw", "Wellington", "Zurich"
    ]

    
    
    @IBOutlet weak var LocationTable: UITableView!
    
    var viewModelWeather = WeatherViewModel()

    var weatherData: [customWeatherModelforCity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModelWeather.fetchWeatherDataForCities(for: majorCities) { _weatherData in
            
            if _weatherData.count > 0 {
                
                
                self.weatherData = _weatherData
                
                DispatchQueue.main.async {
                    self.LocationTable.reloadData()
                }
                
                
            }
      
        }
        
        LocationTable.delegate = self
        LocationTable.dataSource = self
        
        LocationTable.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        
        
    }
   
}


extension LocationViewController:UITableViewDelegate
{
    
}

extension LocationViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = self.LocationTable.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell else
        {
            return UITableViewCell()
        }
        tableViewCell.temperatureLabel.text = weatherData[indexPath.row]._Temperature
        tableViewCell.conditionLabel.text = weatherData[indexPath.row]._Condition
        tableViewCell.locationLabel.text = weatherData[indexPath.row]._Location
        tableViewCell.windSpeedLabel.text = weatherData[indexPath.row]._WindSpeed
        tableViewCell.humidityLabel.text = weatherData[indexPath.row]._Humidity
        
        if weatherData[indexPath.row]._Condition == "Clear"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Clear")
        }
        else if weatherData[indexPath.row]._Condition == "Cloudy"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Cloudy_")
        }
        else if weatherData[indexPath.row]._Condition == "Fog"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Fog")
        }
        else if weatherData[indexPath.row]._Condition == "Rain"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Rain")
        }else if weatherData[indexPath.row]._Condition == "Snow"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Snow")
        }
        else if weatherData[indexPath.row]._Condition == "Thunderstorm"
        {
            tableViewCell.weatherImageView.image = UIImage(named: "Thunderstorm")
        }
        else
        {
            tableViewCell.weatherImageView.image = UIImage(named: "tornado")
        }
        
        
        return tableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 185
    }
    
    
}
