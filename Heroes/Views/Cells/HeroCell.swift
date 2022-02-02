//
//  HeroCell.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit
import SDWebImage

class HeroCell: UITableViewCell {

    let heroImageView = UIImageView()
    let heroTitleLabel = UILabel()
    
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
        heroImageView.backgroundColor = .blue
        heroImageView.layer.cornerRadius = 13
        heroImageView.layer.borderColor = UIColor(red: 200/255, green: 38/255, blue: 38/255, alpha: 0.5).cgColor
        heroImageView.layer.borderWidth = 1
        heroImageView.layer.masksToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroImageView)
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heroImageView.heightAnchor.constraint(equalToConstant: 26),
            heroImageView.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureHeroTitleLabel() {
        heroTitleLabel.text = "Hero name"
        heroTitleLabel.textColor = .label
        heroTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroTitleLabel)
        
        NSLayoutConstraint.activate([
            heroTitleLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 17),
            heroTitleLabel.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor)
        ])
    }
    func bind(imageURL: String, titleLabelText: String) {
        heroImageView.sd_setImage(with: URL(string: imageURL))
        heroTitleLabel.text = titleLabelText
    }
}
