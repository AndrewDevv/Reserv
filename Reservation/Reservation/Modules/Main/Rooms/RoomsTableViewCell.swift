//
//  RoomsTableViewCell.swift
//  Reservation
//
//  Created by Андрей Антонов on 27.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    
    private let roomsLabelCell = UILabel()
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.setTitle("Детали", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        
        contentView.addSubview(roomsLabelCell)
        contentView.addSubview(detailButton)
        
        roomsLabelCell.translatesAutoresizingMaskIntoConstraints = false
        roomsLabelCell.textColor = .white
        NSLayoutConstraint.activate([
            roomsLabelCell.heightAnchor.constraint(equalToConstant: 20),
            roomsLabelCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            roomsLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roomsLabelCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.widthAnchor.constraint(equalToConstant: 70),
            detailButton.heightAnchor.constraint(equalToConstant: 24),
            detailButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            detailButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
            ])
    }
    
    func configure(text: String, isAvailable: Bool, didTapButton: @escaping () -> ()) {
        detailButton.isHidden = !isAvailable
        roomsLabelCell.text = text
        buttonCallback = didTapButton
    }
    
    @objc private func buttonPressed() {
        buttonCallback?()
    }
}
