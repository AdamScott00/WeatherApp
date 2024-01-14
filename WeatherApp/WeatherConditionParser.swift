//
//  WeatherConditionParser.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-12.
//

import Foundation

enum WeatherCondition: Int {
    case Thunderstorm, Drizle, Rain, Snow, Atmosphere, Clear, Clouds, Temp
}

class WeatherConditionParser {
    static let shared = WeatherConditionParser()
    
    private init() {}
    
    func getConditionFromWeatherCode(weatherCode: String) -> WeatherCondition {
        let firstChar = weatherCode.first
        
        switch firstChar {
        case "2":
            return WeatherCondition.Thunderstorm
        case "3":
            return WeatherCondition.Drizle
        case "5":
            return WeatherCondition.Rain
        case "6":
            return WeatherCondition.Snow
        case "7":
            return WeatherCondition.Atmosphere
        case "8":
            return weatherCode.last == "0" ? WeatherCondition.Clear : WeatherCondition.Clouds
        default:
            return WeatherCondition.Temp
        }
    }
}
