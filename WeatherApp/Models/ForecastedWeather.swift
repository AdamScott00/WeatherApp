//
//  ForecastedWeather.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-08.
//

import Foundation

struct ForecastedWeather: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastedWeatherData]
    let city: ForecastedWeatherCity
    
    init(cod: String, message: Int, cnt: Int, list: [ForecastedWeatherData], city: ForecastedWeatherCity) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

struct ForecastedWeatherData: Codable {
    let dt: TimeInterval
    let main: ForecastedWeatherMain
    let weather: [ForecastedWeatherWeather]
    let clouds: ForecastedWeatherClouds
    let wind: ForecastedWeatherWind
    let visibility: Int
    let pop: Double
    let sys: ForecastedWeatherSys
    let dtTxt: String
    
    init(dt: TimeInterval, main: ForecastedWeatherMain, weather: [ForecastedWeatherWeather], clouds: ForecastedWeatherClouds, wind: ForecastedWeatherWind, visibility: Int, pop: Double, sys: ForecastedWeatherSys, dtTxt: String) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.sys = sys
        self.dtTxt = dtTxt
    }
}

struct ForecastedWeatherMain: Codable {
    let temp: Int
    let feelsLike: Int
    let tempMin: Int
    let tempMax: Int
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, feelsLike, tempMin, tempMax, pressure, seaLevel, grndLevel, humidity, tempKf
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        // Helper function to decode Double values, round them, and convert to Int
        func decodeRoundedInt(_ key: CodingKeys) throws -> Int {
            let originalValue = try container.decode(Double.self, forKey: key)
            return Int(originalValue.rounded(.down))
        }
        
        // Decoding rounded and converted to Int values
        temp = try decodeRoundedInt(.temp)
        feelsLike = try decodeRoundedInt(.feelsLike)
        tempMin = try decodeRoundedInt(.tempMin)
        tempMax = try decodeRoundedInt(.tempMax)
        tempKf = try decodeRoundedInt(.tempKf)
        
        // Decoding other properties
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
        seaLevel = try container.decode(Int.self, forKey: .seaLevel)
        grndLevel = try container.decode(Int.self, forKey: .grndLevel)
    }
}

struct ForecastedWeatherWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

struct ForecastedWeatherClouds: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
}

struct ForecastedWeatherWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

struct ForecastedWeatherSys: Codable {
    let pod: String
    
    init(pod: String) {
        self.pod = pod
    }
}

struct ForecastedWeatherCity: Codable {
    let id: Int
    let name: String
    let coord: ForecastedWeatherCoord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
    
    init(id: Int, name: String, coord: ForecastedWeatherCoord, country: String, population: Int, timezone: Int, sunrise: TimeInterval, sunset: TimeInterval) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

struct ForecastedWeatherCoord: Codable {
    let lat: Double
    let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
