//
//  APImanager.swift
//  CloudCast
//
//  Created by shahadat on 14/1/25.
//

import Foundation
//import UIKit
//
//class WeatherViewModel {
//    var weatherData: WeatherResponse?
//
//    func fetchWeatherData() {
//        let urlString = "https://api.weatherapi.com/v1/current.json?key=863b4923dc22487084c83050251201&q=dhaka&aqi=no"
//        
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                self.weatherData = weatherResponse
//                print(self.weatherData ?? "nil")
//            } catch {
//                print("Failed to decode JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//}

class WeatherViewModel {
    var weatherDataList: [WeatherResponse] = []
    
    func fetchWeatherData(for cities: [String]) {
        let apiKey = "863b4923dc22487084c83050251201"
        
        for city in cities {
            let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL for city: \(city)")
                continue
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data for \(city): \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received for \(city)")
                    return
                }
                
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self.weatherDataList.append(weatherResponse)
                    
                    // Safely unwrap and print fetched weather data
                    if let location = weatherResponse.location,
                       let current = weatherResponse.current {
                        let name = location.name ?? "Unknown"
                        let country = location.country ?? "Unknown"
                        let temperature = current.temp_c ?? 0.0
                        let humidity = current.humidity ?? Int(0.0)
                        let windSpeed = current.wind_kph ?? Double(0.0)
                        let condition = current.condition?.text ?? "Unknown"
                        
                        print("Location: \(name), \(country)")
                        print("Temperature: \(temperature)°C")
                        print("Condition: \(condition)")
                        print("Humidity: \(humidity)%")
                        print("Wind Speed: \(windSpeed) km/h")
                    } else {
                        print("Incomplete weather data for \(city)")
                    }
                } catch {
                    print("Failed to decode JSON for \(city): \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
