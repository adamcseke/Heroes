//
//  UIView+Ext.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 03..
//

import UIKit

extension UIView {
    
    func setupImageView(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor(red: 200/255, green: 38/255, blue: 38/255, alpha: 0.5).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 18
        layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            heightAnchor.constraint(equalToConstant: 36),
            widthAnchor.constraint(equalToConstant: 36)
        ])
    }
}

