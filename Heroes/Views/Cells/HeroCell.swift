//
//  HeroCell.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit
import SDWebImage

class HeroCell: UITableViewCell {

    private var heroTitleLabel: UILabel!
    private var imageContentView: MarkerView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        configureHeroImageView()
        configureHeroTitleLabel()
    }
    
    private func configureHeroImageView() {
        imageContentView = MarkerView(width: 26, radius: 13)
        contentView.addSubview(imageContentView)
        imageContentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            imageContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9)
        ])
    }
    
    private func configureHeroTitleLabel() {
        heroTitleLabel = UILabel()
        heroTitleLabel.textColor = .label
        heroTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroTitleLabel)
        
        NSLayoutConstraint.activate([
            heroTitleLabel.leadingAnchor.constraint(equalTo: imageContentView.trailingAnchor, constant: 17),
            heroTitleLabel.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor)
        ])
    }
    func bind(imageURL: String, titleLabelText: String) {
        imageContentView.setImageURL(imageURL: imageURL)
        heroTitleLabel.text = titleLabelText
    }
}
