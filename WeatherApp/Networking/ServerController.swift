//
//  ServerController.swift
//  WeatherApp
//
//  Created by Adam Scott on 2023-12-29.
//

import Foundation
import UIKit

class ServerController {
    static let shared = ServerController()
    
    private init() {}
    
    func getCurrentWeatherData(completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        //Temp values
        let lat = "44.0078"
        let lon = "-78.7229"
        let APIKey = "cf89ed71403338cbc83f2c5e22db62ce"
        
        //Create URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey)&units=metric") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        //Create task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(CurrentWeather.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        //Start task
        task.resume()
    }
    
    func getForecastedWeather(completion: @escaping (Result<ForecastedWeather, Error>) -> Void) {
        //Temp values
        let lat = "44.0078"
        let lon = "-78.7229"
        let APIKey = "cf89ed71403338cbc83f2c5e22db62ce"
        
        //Create URL
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APIKey)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        //Create task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(ForecastedWeather.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        //Start task
        task.resume()
    }
    
    func getWeatherIcon(fromCode code: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        //Create URL
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(code)@2x.png") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        print("Requesting from URL: \(url.absoluteString)")
        
        //Create task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let sendingData = String(data: data!, encoding: .utf8) {
                print("Sending JSON data: \(sendingData)")
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            if let jsonImage = UIImage(data: data) {
                print("Received JSON data: \(jsonImage)")
            }
    
            if let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
        
        //Start task
        task.resume()
    }
}
