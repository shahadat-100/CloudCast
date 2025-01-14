//
//  customWeatherModel.swift
//  CloudCast
//
//  Created by shahadat on 14/1/25.
//

import Foundation

class customWeatherModelforCity{
    
    
    let _Location: String
    let _Temperature: String
    let _Condition: String
    let _Humidity: String
    let _WindSpeed: String
    
    init(_Location: String, _Temperature: String, _Condition: String, _Humidity: String, _WindSpeed: String) {
        self._Location = _Location
        self._Temperature = _Temperature
        self._Condition = _Condition
        self._Humidity = _Humidity
        self._WindSpeed = _WindSpeed
    }
}

class customDayForecastModel{
    
    let _date: String
    let _temperature: [String]
    let _time: [String]
    let _condition: [String]
    
    init(_date: String, _temperature: [String], _time: [String], _condition: [String]) {
        self._date = _date
        self._temperature = _temperature
        self._time = _time
        self._condition = _condition
    }
}

