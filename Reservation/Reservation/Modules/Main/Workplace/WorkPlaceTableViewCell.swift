//
//  WorkPlaceTableViewCell.swift
//  Reservation
//
//  Created by Андрей Антонов on 28.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

class WorkPlaceTableViewCell: UITableViewCell {
    
    private let workplaceButton: UIButton = {
        let workButton = UIButton()
        workButton.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        workButton.titleLabel?.font = .systemFont(ofSize: 14)
        workButton.layer.cornerRadius = 5
        workButton.tintColor = .white
        workButton.layer.shadowRadius = 7
        workButton.layer.shadowOpacity = 0.7
        workButton.layer.shadowColor = UIColor.black.cgColor
        return workButton
    }()
    
    private lazy var detailWorkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.setTitle("Детали", for: .normal)
        button.titleLabel?.textColor = .white
        button.setImage(UIImage(named: "transition"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.layer.cornerRadius = 5
        button.imageEdgeInsets.left = 10
        button.tintColor = .white
        button.layer.shadowRadius = 7
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var buttonCallback: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    @objc private func buttonPressed() {
        buttonCallback?()
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(workplaceButton)
        contentView.addSubview(detailWorkButton)
        contentView.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        
        workplaceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workplaceButton.widthAnchor.constraint(equalToConstant: 148),
            workplaceButton.heightAnchor.constraint(equalToConstant: 29),
            workplaceButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            workplaceButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            workplaceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        
        detailWorkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailWorkButton.widthAnchor.constraint(equalToConstant: 70),
            detailWorkButton.heightAnchor.constraint(equalToConstant: 24),
            detailWorkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            detailWorkButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
            ])
    }
    
    func configure(isAvailable: Bool, text: String, didTapButton: @escaping () -> ()) {
        detailWorkButton.isHidden = !isAvailable
        workplaceButton.setTitle(text, for: .normal)
        buttonCallback = didTapButton
    }
}
