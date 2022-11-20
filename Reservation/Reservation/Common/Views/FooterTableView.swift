//
//  FooterTableView.swift
//  Reservation
//
//  Created by Андрей Антонов on 26.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

class FooterTableView: UIView {
    
    private let transitionImage = UIImageView(image: UIImage(named: "scrollArrow"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(transitionImage)
        transitionImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transitionImage.widthAnchor.constraint(equalToConstant: 20),
            transitionImage.heightAnchor.constraint(equalToConstant: 20),
            transitionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            transitionImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
}
