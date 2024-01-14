//
//  WeatherInfoMainView.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-05.
//

import UIKit

class WeatherInfoMainView: UIView {
    let cityNameLabel = UILabel()
    let currentTemperatureLabel = UILabel()
    let weatherDescriptionLabel = UILabel()
    let tempMinMaxLabel = SideBySideLabelsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.3, green: 0.425, blue: 0.5, alpha: 0.9)
        
        cityNameLabel.font = UIFont.systemFont(ofSize: 30)
        
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 58)
        
        weatherDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        tempMinMaxLabel.leftLabel.font = UIFont.systemFont(ofSize: 16)
        tempMinMaxLabel.rightLabel.font = UIFont.systemFont(ofSize: 16)
        
        addSubview(cityNameLabel)
        addSubview(currentTemperatureLabel)
        addSubview(weatherDescriptionLabel)
        addSubview(tempMinMaxLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempMinMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8.0).isActive = true
        currentTemperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        weatherDescriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 8.0).isActive = true
        weatherDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        tempMinMaxLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 8.0).isActive = true
        tempMinMaxLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8.0).isActive = true
        tempMinMaxLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
