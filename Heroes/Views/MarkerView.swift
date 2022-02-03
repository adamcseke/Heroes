//
//  MarkerView.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 03..
//

import UIKit
import SDWebImage

class MarkerView: UIView {
    
    private var markerImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    init(width: CGFloat, radius: CGFloat) {
        super.init(frame: .zero)
        configureMarkerImageView(width: width, radius: radius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMarkerImageView(width: CGFloat, radius: CGFloat) {
        markerImageView = UIImageView()
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor(red: 200/255, green: 38/255, blue: 38/255, alpha: 0.5).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = radius
        layer.masksToBounds = true
        markerImageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        addSubview(markerImageView)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: width),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func setImageURL(imageURL: String) {
        markerImageView.sd_setImage(with: URL(string: imageURL))
    }
    
}
