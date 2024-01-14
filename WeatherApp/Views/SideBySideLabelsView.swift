//
//  SideBySideLabelsView.swift
//  WeatherApp
//
//  Created by Adam Scott on 2024-01-05.
//

import UIKit

class SideBySideLabelsView: UIView {
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(leftLabel)
        addSubview(rightLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -4.0).isActive = true
        
        rightLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rightLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 4.0).isActive = true
        
    }
}
