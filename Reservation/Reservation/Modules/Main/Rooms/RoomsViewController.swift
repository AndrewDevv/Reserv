//
//  RoomsViewController.swift
//  Reservation
//
//  Created by Андрей Антонов on 27.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class RoomsViewController: UIViewController {
    
    private let roomsLabel = UILabel()
    private let roomsTableView = UITableView()
    private let spinner = UIActivityIndicatorView()
    
    private let viewModel = RoomsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRooms()
        setupRoomsUI()
        bindViewModel()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }
}

// MARK: - TableviewDelegate
extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerRoomView = FooterTableView()
        return footerRoomView
    }
}

// MARK: - TableView
private extension RoomsViewController {
    func setupRooms() {
        roomsTableView.delegate = self
        roomsTableView.register(RoomsTableViewCell.self,
                                forCellReuseIdentifier: String(describing: RoomsTableViewCell.self))
        roomsTableView.separatorStyle = .none
        roomsTableView.layer.cornerRadius = 20
        roomsTableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func bindViewModel() {
        viewModel.transform().result
            .bind(to: roomsTableView.rx.items(cellIdentifier: String(describing: RoomsTableViewCell.self),
                                              cellType: RoomsTableViewCell.self)) { row, rooms, cell in
                                                cell.configure(text: rooms.name,
                                                               isAvailable: rooms.isAvailable,
                                                               didTapButton: {
                                                                RoomsRouter().pushRooms(sourceVC: self)
                                                })
            }
            .disposed(by: disposeBag)
    }
    
    func setupRoomsUI() {
        view.backgroundColor = .white
        
        view.addSubview(roomsLabel)
        view.addSubview(roomsTableView)
        view.addSubview(spinner)
        
        roomsLabel.text = "Помещение"
        roomsLabel.font = .systemFont(ofSize: 23, weight: .bold)
        roomsLabel.textColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        roomsTableView.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        roomsLabel.translatesAutoresizingMaskIntoConstraints = false
        roomsTableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomsLabel.widthAnchor.constraint(equalToConstant: 150),
            roomsLabel.heightAnchor.constraint(equalToConstant: 28),
            roomsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            roomsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            roomsTableView.widthAnchor.constraint(equalToConstant: 337),
            roomsTableView.heightAnchor.constraint(equalToConstant: 300),
            roomsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 152),
            roomsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19)
            ])
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 15),
            spinner.heightAnchor.constraint(equalToConstant: 15),
            spinner.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
