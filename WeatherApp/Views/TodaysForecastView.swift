//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-07.
//

import UIKit

class TodaysForecastView: UIView {

    let titleLabel = UILabel()
    let scrollableHourlyView = ScrollableForecastView()
    var iconImage = UIImage()
    
    init() {
        super.init(frame: .zero)
        
        titleLabel.text = "Today's Forecast"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        addSubview(titleLabel)
        addSubview(scrollableHourlyView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollableHourlyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8.0),
            
            scrollableHourlyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            scrollableHourlyView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollableHourlyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollableHourlyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollableHourlyView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
}
