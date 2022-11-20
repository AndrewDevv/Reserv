//
//  ContentTableViewCell.swift
//  Reservation
//
//  Created by Андрей Антонов on 22.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    private let mapImage = UIImageView(image: UIImage(named: "map"))
    private let transitionImage = UIImageView(image: UIImage(named: "transition"))
    private let cityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(mapImage)
        contentView.addSubview(cityLabel)
        contentView.addSubview(transitionImage)
        backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        selectionStyle = .none
        
        cityLabel.textColor = .white
        mapImage.image = mapImage.image?.withRenderingMode(.alwaysTemplate)
        mapImage.tintColor = .white
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        mapImage.translatesAutoresizingMaskIntoConstraints = false
        transitionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            transitionImage.widthAnchor.constraint(equalToConstant: 20),
            transitionImage.heightAnchor.constraint(equalToConstant: 20),
            transitionImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            transitionImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            transitionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            mapImage.heightAnchor.constraint(equalToConstant: 20),
            mapImage.widthAnchor.constraint(equalToConstant: 20),
            mapImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mapImage.leftAnchor.constraint(equalTo: cityLabel.rightAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
            ])
    }
    
    func configure(text: String) {
        cityLabel.text = text
    }
}
