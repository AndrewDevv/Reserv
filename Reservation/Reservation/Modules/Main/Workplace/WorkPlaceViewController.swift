//
//  WorkPlaceViewController.swift
//  Reservation
//
//  Created by Андрей Антонов on 28.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class WorkPlaceViewController: UIViewController {
    
    private let workLabel = UILabel()
    private let workplaceTableView = UITableView()
    private let spinner = UIActivityIndicatorView()
    
    private let viewModel = WorkplaceViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorkplaceUI()
        setupWorkPlaceTableView()
        bindViewModel()
    }
}

// MARK: - TableViewDelegate
extension WorkPlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerWorkPlace = FooterWorkPlace()
        return footerWorkPlace
    }
}

// MARK: - TableView
private extension WorkPlaceViewController {
    func setupWorkPlaceTableView() {
        workplaceTableView.delegate = self
        workplaceTableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        workplaceTableView.separatorStyle = .none
        workplaceTableView.register(WorkPlaceTableViewCell.self,
                                    forCellReuseIdentifier: String(describing: WorkPlaceTableViewCell.self))
    }
    
    func bindViewModel() {
        viewModel.transform().result
            .bind(to: workplaceTableView.rx.items(cellIdentifier: String(describing: WorkPlaceTableViewCell.self),
                                                  cellType: WorkPlaceTableViewCell.self)) { row, workplace, cell in
                                                    cell.configure(
                                                        isAvailable: workplace.isAvailable,
                                                        text: "\(workplace.name) \(workplace.number)",
                                                        didTapButton: {
                                                            WorkplaceRouter().pushWorkplace(sourceVC: self)
                                                    })
            }
            .disposed(by: disposeBag)
    }
    
    func setupWorkplaceUI() {
        view.addSubview(workplaceTableView)
        view.addSubview(workLabel)
        view.backgroundColor = .white
        
        workLabel.text = "Рабочие места"
        workLabel.font = .systemFont(ofSize: 23, weight: .bold)
        workLabel.textColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        
        workplaceTableView.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        workplaceTableView.layer.cornerRadius = 20
        workplaceTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workplaceTableView.widthAnchor.constraint(equalToConstant: 337),
            workplaceTableView.heightAnchor.constraint(equalToConstant: 320),
            workplaceTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 153),
            workplaceTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19)
            ])
        workLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workLabel.widthAnchor.constraint(equalToConstant: 185),
            workLabel.heightAnchor.constraint(equalToConstant: 28),
            workLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            workLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
