//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by Adam Scott on 2023-12-28.
//

import UIKit

class WeatherInfoViewController: UIViewController {
    let degreesString = " °C"
    
    var currentWeather: CurrentWeather?
    var forecastedWeather: ForecastedWeather?
    
    let backgroundImageView = UIImageView()
    let weatherInfoMainView = WeatherInfoMainView()
    let todaysForecastView = TodaysForecastView()
    
    init(currentWeather: CurrentWeather, forecastedWeather: ForecastedWeather) {
        self.currentWeather = currentWeather
        self.forecastedWeather = forecastedWeather
         
        super.init(nibName: nil, bundle: nil)
        
        weatherInfoMainView.backgroundColor = UIColor(red: 0.3, green: 0.425, blue: 0.5, alpha: 0.9)
        todaysForecastView.backgroundColor = UIColor(red: 0.3, green: 0.425, blue: 0.5, alpha: 0.9)
        
        setupBackgroundView()
        setupCurrentWeatherView()
        setupForecastedWeatherView()
        
        view.addSubview(backgroundImageView)
        view.addSubview(weatherInfoMainView)
        view.addSubview(todaysForecastView)
        view.sendSubviewToBack(backgroundImageView)
        
        setConstraints()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundView() {
        let currentWeatherCode = String(self.currentWeather?.weather.first?.id ?? 9)
        var currentWeatherCondition = WeatherConditionParser.shared.getConditionFromWeatherCode(weatherCode: currentWeatherCode)
        
//        currentWeatherCondition = WeatherCondition.Snow
        
        switch currentWeatherCondition {
        case WeatherCondition.Thunderstorm:
            backgroundImageView.image = UIImage(named: "Thunderstorm")
        case WeatherCondition.Drizle:
            backgroundImageView.image = UIImage(named: "Drizzle")
        case WeatherCondition.Rain:
            backgroundImageView.image = UIImage(named: "Rain")
        case WeatherCondition.Snow:
            backgroundImageView.image = UIImage(named: "Snow")
        case WeatherCondition.Atmosphere:
            backgroundImageView.image = UIImage(named: "Atmosphere")
        case WeatherCondition.Clear:
            backgroundImageView.image = UIImage(named: "Clear")
        case WeatherCondition.Clouds:
            backgroundImageView.image = UIImage(named: "Cloudy")
        default:
            self.view.backgroundColor = .gray
        }
        
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setupForecastedWeatherView() {
        self.todaysForecastView.layer.cornerRadius = 10
        self.todaysForecastView.layer.masksToBounds = true
        
        let dispatchGroup = DispatchGroup()

        for index in stride(from: 0, to: 8, by: 1) {
            dispatchGroup.enter()

            if let forecastedWeatherInfoData = self.forecastedWeather?.list[index] {
                let timestamp = forecastedWeatherInfoData.dt
                let date = Date(timeIntervalSince1970: timestamp)

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "ha"  // Format for hours and AM/PM

                let timeText = dateFormatter.string(from: date)
                let temperature = String(forecastedWeatherInfoData.main.temp) + degreesString // Use a default value if temperature is nil

                let iconCode = forecastedWeatherInfoData.weather.first?.icon ?? ""

                ServerController.shared.getWeatherIcon(fromCode: iconCode) { [weak self] result in
                    switch result {
                    case .success(let iconImage):
                        // Dispatch UI-related code to the main thread
                        DispatchQueue.main.async {
                            let forecastedWeatherInfoView = ForecastedWeatherInfoView(timeText: timeText, weatherIconImage: iconImage, temperature: temperature)
                            self?.todaysForecastView.scrollableHourlyView.forecastedViewArray.append(forecastedWeatherInfoView)
                        }

                    case .failure(let error):
                        print("Error fetching icon image: \(error)")
                    }
                    dispatchGroup.leave()
                }
            } else {
                // Handle the case where forecastedWeatherInfoData is nil
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            // Perform the operation after all server calls are done
            print("All server calls completed")
            self.todaysForecastView.scrollableHourlyView.setupForecastedViews()
        }
    }


    
    private func setupCurrentWeatherView() {
        let tempMax = String(self.currentWeather?.main.tempMax ?? 0)
        let tempMin = String(self.currentWeather?.main.tempMin ?? 0)
        self.weatherInfoMainView.cityNameLabel.text = self.currentWeather?.name
        self.weatherInfoMainView.currentTemperatureLabel.text = String(self.currentWeather?.main.temp ?? 0) + degreesString
        self.weatherInfoMainView.weatherDescriptionLabel.text = self.currentWeather?.weather.first?.main
        self.weatherInfoMainView.tempMinMaxLabel.leftLabel.text = "H: " + String(self.currentWeather?.main.tempMax ?? 0) + degreesString
        self.weatherInfoMainView.tempMinMaxLabel.rightLabel.text = "L: " + String(self.currentWeather?.main.tempMin ?? 0) + degreesString
        
        self.weatherInfoMainView.layer.cornerRadius = 10
    }

    func setConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoMainView.translatesAutoresizingMaskIntoConstraints = false
        todaysForecastView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            weatherInfoMainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128.0),
            weatherInfoMainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            todaysForecastView.topAnchor.constraint(equalTo: weatherInfoMainView.bottomAnchor, constant: 64.0),
            todaysForecastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todaysForecastView.widthAnchor.constraint(equalToConstant: 360.0)
        ])
    }
}
