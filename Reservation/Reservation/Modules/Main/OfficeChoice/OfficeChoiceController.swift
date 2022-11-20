//
//  OfficeChoice.swift
//  Reservation
//
//  Created by Андрей Антонов on 22.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class OfficeChoiceController: UIViewController {
    
    @IBOutlet private weak var officeChoice: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Профиль", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = OfficesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOfficeChoiceUI()
        setupOfficeChoice()
        bindTableView()
        setup()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
}

// MARK: - TableViewDelegate
extension OfficeChoiceController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterTableView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomsController = RoomsViewController()
        navigationController?.pushViewController(roomsController, animated: true)
    }
}

// MARK: - TableView
private extension OfficeChoiceController {
    func setupOfficeChoice() {
        officeChoice.delegate = self
        officeChoice.register(ContentTableViewCell.self,
                              forCellReuseIdentifier: String(describing: ContentTableViewCell.self))
        officeChoice.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    func bindTableView() {
        viewModel.transform().result
            .subscribe { (office) in
                if office.isCompleted {
                    self.spinner.startAnimating()
                    self.spinner.isHidden = false
                } else {
                    self.spinner.isHidden = true
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.transform().result
            .bind(to: officeChoice.rx.items(cellIdentifier: String(describing: ContentTableViewCell.self),
                                            cellType: ContentTableViewCell.self)) { row, office, cell in
                                                cell.configure(text: "\(office.number) \(office.name)")
            }
            .disposed(by: disposeBag)
    }
    
    func setupOfficeChoiceUI() {
        officeChoice.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        officeChoice.separatorStyle = .none
        officeChoice.layer.cornerRadius = 20
        officeChoice.layer.shadowColor = UIColor.black.cgColor
        officeChoice.layer.shadowRadius = 4
        officeChoice.layer.shadowOpacity = 0.5
        officeChoice.layer.shadowOffset = CGSize(width: 0, height: 4)
        officeChoice.clipsToBounds = false
    }
    
    func setup() {
        view.addSubview(profileButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.widthAnchor.constraint(equalToConstant: 80),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.topAnchor.constraint(equalTo: officeChoice.bottomAnchor, constant: 40),
            profileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
            ])
    }
}

extension OfficeChoiceController {
    @objc private func buttonPressed() {
        let profileModalView = ProfileViewController()
        profileModalView.modalPresentationStyle = .currentContext
        self.navigationController?.present(profileModalView, animated: true, completion: nil)
    }
}
