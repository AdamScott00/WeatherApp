//
//  ScrollableHourlyViews.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-07.
//

import UIKit

class ScrollableForecastView: UIScrollView {
    var forecastedViewArray:[ForecastedWeatherInfoView] = []
    
    func setupForecastedViews() {
        var previousView: ForecastedWeatherInfoView?

        for view in forecastedViewArray {
            view.translatesAutoresizingMaskIntoConstraints = false

            addSubview(view)

            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor),
                view.widthAnchor.constraint(equalToConstant: 64.0),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

            if let previousView = previousView {
                view.leadingAnchor.constraint(equalTo: previousView.trailingAnchor).isActive = true
            } else {
                view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            }

            previousView = view
        }

        // Set the trailing constraint for the last label
        if let lastView = previousView {
            lastView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    //TODO: Put in a UIView Extension, rename
    private func arrayTranslatesAutoresizingMaskIntoConstraints(array: [UIView]) {
        array.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
