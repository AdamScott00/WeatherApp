//
//  ForecastedWeatherView.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-08.
//

import UIKit

class ForecastedWeatherInfoView: UIView {
    
    let timeLabel = UILabel()
    let weatherIconImageView = UIImageView()
    let temperatureLabel = UILabel()
    
    init(timeText: String, weatherIconImage: UIImage, temperature: String) {
        super.init(frame: .zero)
        
        timeLabel.text = timeText
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        weatherIconImageView.image = weatherIconImage
        
        temperatureLabel.text = temperature
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        //debugging
        weatherIconImageView.contentMode = .scaleAspectFit
        print("Image Size: \(weatherIconImageView.image?.size)")
//        weatherIconImageView.backgroundColor = .yellow 
        
        addSubview(timeLabel)
        addSubview(weatherIconImageView)
        addSubview(temperatureLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeatherIcon(fromImage image: UIImage) {
        weatherIconImageView.image = image
    }
    
    private func setConstraints() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherIconImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8.0),
            weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 8.0),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4.0)
        ])
    }

}
