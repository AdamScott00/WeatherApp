//
//  LoadingScreenViewController.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-08.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup and start the activity indicator
        setupActivityIndicator()

        ServerController.shared.getCurrentWeatherData { [weak self] result in
           
            switch result {
            case .success(let currentWeatherData):
                
                ServerController.shared.getForecastedWeather { [weak self] result in
                    // Stop the activity indicator when data is received
                    defer {
                        DispatchQueue.main.async {
                            self?.activityIndicatorView.stopAnimating()
                        }
                    }
                    
                    switch result {
                    case .success(let forecastedWeatherData):
                        self?.loadWeatherInfoVC(currentWeather: currentWeatherData, forecastedWeather: forecastedWeatherData)
                        
                    case .failure(let error):
                        print("Error fetching forecasted weather: \(error)")
                    }
                    
                }

            case .failure(let error):
                print("Error fetching current weather data: \(error)")
                // Handle the error as needed
            }
        }
    }

    private func loadWeatherInfoVC(currentWeather: CurrentWeather, forecastedWeather: ForecastedWeather) {
        DispatchQueue.main.async {
            let VC = WeatherInfoViewController(currentWeather: currentWeather, forecastedWeather: forecastedWeather)
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .gray
        view.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        activityIndicatorView.startAnimating()
    }

    func getCurrentWeatherData() {
        
    }
}
