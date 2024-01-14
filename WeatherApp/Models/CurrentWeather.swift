//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Adam Scott on 2023-12-30.
//

import Foundation

struct CurrentWeather: Codable {
    var coord: CurrentWeatherCoord
    var weather: [CurrentWeatherWeather]
    var base: String
    var main: CurrentWeatherMain
    var visibility: Int
    var wind: CurrentWeatherWind
    var clouds: CurrentWeatherClouds
    var dt: Int
    var sys: CurrentWeatherSys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    init(coord: CurrentWeatherCoord, weather: [CurrentWeatherWeather], base: String, main: CurrentWeatherMain, visibility: Int, wind: CurrentWeatherWind, clouds: CurrentWeatherClouds, dt: Int, sys: CurrentWeatherSys, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}

struct CurrentWeatherCoord: Codable {
    var lon: Double
    var lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

struct CurrentWeatherWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

struct CurrentWeatherMain: Codable {
    var temp: Int
    var feelsLike: Int
    var tempMin: Int
    var tempMax: Int
    var pressure: Int
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, feelsLike, tempMin, tempMax, pressure, humidity
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
        
        // Decoding other properties
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

struct CurrentWeatherWind: Codable {
    var speed: Double
    var deg: Int
    
    init(speed: Double, deg: Int) {
        self.speed = speed
        self.deg = deg
    }
}

struct CurrentWeatherClouds: Codable {
    var all: Int //Cloudiness %
    
    init(all: Int) {
        self.all = all
    }
}

struct CurrentWeatherSys: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int // Time, UNIX, UCT
    var sunset: Int // Time, UNIX, UCT
    
    init(type: Int, id: Int, country: String, sunrise: Int, sunset: Int) {
        self.type = type
        self.id = id
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
