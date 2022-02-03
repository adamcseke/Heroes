//
//  HeroCell.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit
import SDWebImage

class HeroCell: UITableViewCell {

    var heroImageView: UIImageView!
    var heroTitleLabel: UILabel!
    var imageContentView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        configureHeroImageView()
        configureHeroTitleLabel()
    }
    
    func configureHeroImageView() {
        heroImageView = UIImageView()
        imageContentView = UIView()
        contentView.addSubview(imageContentView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        imageContentView.addSubview(heroImageView)
        imageContentView.setupImageView(of: heroImageView)
        
        NSLayoutConstraint.activate([
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    func configureHeroTitleLabel() {
        heroTitleLabel = UILabel()
        heroTitleLabel.textColor = .label
        heroTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroTitleLabel)
        
        NSLayoutConstraint.activate([
            heroTitleLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 17),
            heroTitleLabel.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor)
        ])
    }
    func bind(imageURL: String, titleLabelText: String) {
        heroImageView.sd_setImage(with: URL(string: imageURL))
        heroTitleLabel.text = titleLabelText
    }
}
