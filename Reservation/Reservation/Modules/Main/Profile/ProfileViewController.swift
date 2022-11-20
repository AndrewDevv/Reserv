//
//  ProfileViewController.swift
//  Reservation
//
//  Created by Андрей Антонов on 04.10.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private let avatar = UIImageView()
    
    private var userName = UITextField()
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("save", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.tintColor = .white
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        cashImage()
        text()
    }
    
    @objc func save() {
        UserDefaults.standard.set(userName.text, forKey: "UserName")
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController {
    private func setupUI() {
        view.addSubview(avatar)
        view.addSubview(userName)
        view.addSubview(saveButton)
        
        view.backgroundColor = .white
        
        avatar.backgroundColor = .green
        avatar.layer.cornerRadius = 40
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 80),
            avatar.widthAnchor.constraint(equalToConstant: 80),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            ])
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.backgroundColor = .gray
        userName.layer.cornerRadius = 5
        userName.attributedPlaceholder = NSAttributedString(string: "Имя пользователя",
                                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        NSLayoutConstraint.activate([
            userName.heightAnchor.constraint(equalToConstant: 30),
            userName.widthAnchor.constraint(equalToConstant: 120),
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            userName.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
            ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            ])
    }
}

private extension ProfileViewController {
    func cashImage() {
        let url = URL(string: "https://icdn.lenta.ru/images/2021/04/27/16/20210427163138131/square_320_c09ebae17387b7d6eeb9fa0d42afe5ee.jpg")
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        avatar.kf.setImage(with: url, options: [.processor(processor)])
    }
    
    func text() {
        userName.text = UserDefaults.standard.string(forKey: "UserName")
    }
}
