//
//  APImanager.swift
//  CloudCast
//
//  Created by shahadat on 14/1/25.
//

import Foundation

class WeatherViewModel {
    
    func fetchWeatherDataForCities(for cities: [String], completion: @escaping ([customWeatherModelforCity]) -> Void) {
        
        let apiKey = "863b4923dc22487084c83050251201"
        var weatherDataList: [customWeatherModelforCity] = []
        var completedRequests = 0
        
        for city in cities {
            let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL for city: \(city)")
                completedRequests += 1
                if completedRequests == cities.count {
                    completion(weatherDataList)
                }
                continue
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                completedRequests += 1
                
                if let error = error {
                    print("Error fetching data for \(city): \(error.localizedDescription)")
                    if completedRequests == cities.count {
                        completion(weatherDataList)
                    }
                    return
                }
                
                guard let data = data else {
                    print("No data received for \(city)")
                    if completedRequests == cities.count {
                        completion(weatherDataList)
                    }
                    return
                }
                
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    
                    if let location = weatherResponse.location,
                       let current = weatherResponse.current {
                        let name = location.name ?? "Unknown"
                        let country = location.country ?? "Unknown"
                        let temperature = current.temp_c ?? 0.0
                        let humidity = current.humidity ?? 0
                        let windSpeed = current.wind_kph ?? 0.0
                        let condition = current.condition?.text ?? "Unknown"
                        
                        let simplifiedCondition = self.simplifyCondition(from: condition)
                        
                        let weatherModel = customWeatherModelforCity(
                            _Location: "\(name), \(country)",
                            _Temperature: "\(temperature)°C",
                            _Condition: simplifiedCondition,
                            _Humidity: "Humidity: \(humidity)%",
                            _WindSpeed: "Wind Speed: \(windSpeed) km/h"
                        )
                        
//                        print(city+country)
//                        print(condition)
//                        print(simplifiedCondition)
                        
                        weatherDataList.append(weatherModel)
                    } else {
                        print("Incomplete weather data for \(city)")
                    }
                } catch {
                    print("Failed to decode JSON for \(city): \(error.localizedDescription)")
                }
                
                // Call completion when all requests are processed
                if completedRequests == cities.count {
                    completion(weatherDataList)
                }
            }.resume()
        }
    }
    
    
    func fetchWeatherDataForCity(city: String, completion: @escaping (customWeatherModelforCity?) -> Void) {
        let apiKey = "863b4923dc22487084c83050251201"
        

        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL for city: \(city)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data for \(city): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received for \(city)")
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                if let location = weatherResponse.location, let current = weatherResponse.current {
                    let name = location.name ?? "Unknown"
                   // let country = location.country ?? "Unknown"
                    let temperature = current.temp_c ?? 0.0
                    let humidity = current.humidity ?? 0
                    let windSpeed = current.wind_kph ?? 0.0
                    let condition = current.condition?.text ?? "Unknown"
                    let simplifiedCondition = self.simplifyCondition(from: condition)
                    
                    
                    let weatherModel = customWeatherModelforCity(
                        _Location: "\(name)",
                        _Temperature: "\(temperature)°C",
                        _Condition: simplifiedCondition,
                        _Humidity: "Humidity: \(humidity)%",
                        _WindSpeed: "Wind Speed: \(windSpeed) km/h"
                    )
                    
                    completion(weatherModel)
                } else {
                    print("Incomplete weather data for \(city)")
                    completion(nil)
                }
            } catch {
                print("Failed to decode JSON for \(city): \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    
    
    
//    func fetchHourlyForecast(for city: String, completion: @escaping (customDayForecastModel?) -> Void) {
//        let apiKey = "863b4923dc22487084c83050251201"
//        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=1&aqi=no&alerts=no"
//        //"https://api.weatherapi.com/v1/forecast.json?key=863b4923dc22487084c83050251201&q=dhaka&days=1&aqi=no&alerts=no"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL for city: \(city)")
//            completion(nil)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data for \(city): \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received for \(city)")
//                completion(nil)
//                return
//            }
//            
//            do {
//                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                print("Weather data received successfully.")
//                
//                if let forecastDay = weatherResponse.forecast?.forecastday?.first {
//                    let dateString = forecastDay.date
//                    let hourlyForecast = forecastDay.hour
//                    
//                    var timeArray: [String] = []
//                    var tempArray: [String] = []
//                    var conditionArray: [String] = []
//                    
//                    for perHour in hourlyForecast ?? [] {
//                        let temp = perHour.temp_c ?? 0.0
//                        let timeString = (perHour.time ?? "").components(separatedBy: " ").last ?? ""
//                        let condition = perHour.condition?.text ?? "Unknown"
//                        let simplifiedCondition = self.simplifyCondition(from: condition)
//                        
//                        timeArray.append(timeString)
//                        tempArray.append("\(temp)°C")
//                        conditionArray.append(simplifiedCondition)
//                    }
//                    
//                    let hourlyForecastModel = customDayForecastModel(
//                        _date: dateString ?? "",
//                        _temperature: tempArray,
//                        _time: timeArray,
//                        _condition: conditionArray
//                    )
//                    
//                    completion(hourlyForecastModel)
//                } else {
//                    print("Incomplete weather data for \(city)")
//                    completion(nil)
//                }
//            } catch {
//                print("Failed to decode JSON for \(city): \(error.localizedDescription)")
//                completion(nil)
//            }
//        }.resume()
//    }

    
//    func tryApi(city: String)
//    {
//      //  let apiKey = "863b4923dc22487084c83050251201"
//      //  let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=1&aqi=no&alerts=no"
//        
//        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=863b4923dc22487084c83050251201&q=dhaka&days=1&aqi=no&alerts=no") else {
//            print("Invalid URL for city: \(city)")
//
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching weather data: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            // Print the raw JSON for debugging
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON Response: \(jsonString)")
//            }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            decoder.dateDecodingStrategy = .iso8601
//            decoder.dataDecodingStrategy = .base64
//            
//            do {
//                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
//                let hourlyForecast = weatherData.current
//
//                print("Hourly Forecast:\(hourlyForecast)")
////                hourlyForecast?.forEach { hour in
////                    print("""
////                    Time: \(hour.time)
////                    Temperature: \(hour.temp_c)°C
////                    Condition: \(hour.condition?.text)
////                    Icon URL: \(hour.condition?.icon)
////                    """)
////                }
//            } catch {
//                print("Failed to decode JSON: \(error)")
//            }
//        }
//        task.resume()
//
//    }
    

    
    
    private func simplifyCondition(from condition: String) -> String {
        
        let conditionMapping: [String: String] = [
            
            "Clear": "Clear",
            "Sunny": "Clear",
            "Partly cloudy": "Clear",
            
            "Cloudy": "Cloudy",
            "Overcast": "Cloudy",
            
            "Mist": "Fog",
            "Fog": "Fog",
            "Freezing fog": "Fog",
 
            "Patchy freezing drizzle possible": "Rain",
            "Patchy rain possible": "Rain",
            "Patchy light drizzle": "Rain",
            "Light drizzle": "Rain",
            "Freezing drizzle": "Rain",
            "Heavy freezing drizzle": "Rain",
            "Patchy light rain": "Rain",
            "Light rain": "Rain",
            "Moderate rain at times": "Rain",
            "Moderate rain": "Rain",
            "Heavy rain at times": "Rain",
            "Heavy rain": "Rain",
            "Light freezing rain": "Rain",
            "Moderate or heavy freezing rain": "Rain",
            "Light rain shower": "Rain",
            "Moderate or heavy rain shower": "Rain",
            "Torrential rain shower": "Rain",
            
            
            
            "Light sleet": "Snow",
            "Moderate or heavy sleet": "Snow",
            "Patchy light snow": "Snow",
            "Light snow": "Snow",
            "Patchy moderate snow": "Snow",
            "Moderate snow": "Snow",
            "Patchy heavy snow": "Snow",
            "Heavy snow": "Snow",
            "Ice pellets": "Snow",
            "Blowing snow": "Snow",
            "Blizzard": "Snow",
            "Patchy snow possible": "Snow",
            "Patchy sleet possible": "Snow",
            "Light sleet showers": "Snow",
            "Moderate or heavy sleet showers": "Snow",
            "Light snow showers": "Snow",
            "Moderate or heavy snow showers": "Snow",
            "Light showers of ice pellets": "Snow",
            "Moderate or heavy showers of ice pellets": "Snow",
            
            
            
            "Thundery outbreaks possible": "Thunderstorm",
            "Patchy light rain with thunder": "Thunderstorm",
            "Moderate or heavy rain with thunder": "Thunderstorm",
            "Patchy light snow with thunder": "Thunderstorm",
            "Moderate or heavy snow with thunder": "Thunderstorm"
        ]

        
      //  print(condition+"+")
        return conditionMapping[condition] ?? "Unknown_ "
    }
}




