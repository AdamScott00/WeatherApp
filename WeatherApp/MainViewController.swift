//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Adam Scott on 2023-12-28.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let VC = LoadingScreenViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
