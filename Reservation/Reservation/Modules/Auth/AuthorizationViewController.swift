//
//  AuthorizationViewController.swift
//  Reservation
//
//  Created by Андрей Антонов on 31.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

final class AuthorizationViewController: UIViewController {
    
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private lazy var buttonСontinue: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        return button
    }()
    private var viewModel = AuthViewModel(authService: AuthService())
    private let disposeBag = DisposeBag()
    private let serviceCoreData = ServiceCoreData()
    private let serviceParsing = ServiceParse<User>()
    private let serviceRead = ServiceReadJSON()
    private let serviceCoreDataOperation = ServiceCoreDataOperation()
    private var userArray: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldUI()
        bindViewModel()
        }
}

// MARK: - Setup constraint
private extension AuthorizationViewController {
    func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(buttonСontinue)
        
        view.backgroundColor = .white
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 307),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 370),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        buttonСontinue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonСontinue.widthAnchor.constraint(equalToConstant: 165),
            buttonСontinue.heightAnchor.constraint(equalToConstant: 55),
            buttonСontinue.topAnchor.constraint(equalTo: view.topAnchor, constant: 515),
            buttonСontinue.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    func setupTextFieldUI() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Номер телефона или e-mail",
                                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        emailTextField.layer.cornerRadius = 10
        emailTextField.textAlignment = .center
        emailTextField.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        emailTextField.textColor = UIColor(displayP3Red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.textAlignment = .center
        passwordTextField.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        passwordTextField.textColor = UIColor(displayP3Red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
    }
}

// MARK: - Rx setup
private extension AuthorizationViewController {
    var input: AuthViewModel.Input {
        return AuthViewModel.Input(
                    loginText: emailTextField.rx.text.orEmpty.asDriver(),
                    passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
                    authButtonTapped: buttonСontinue.rx.tap.asSignal()
                )
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
        
        output.authResult
            .do(onError: { [weak self] error in
                guard let self = self else { return }
                let alertController = UIAlertController(title: "Ошибка",
                                                        message: "Неправильный логин или пароль, повторите попытку",
                                                        preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            })
            .retry(3)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                AuthViewRouter().pushView(sourceVC: self)
            })
        .disposed(by: disposeBag)
    }
}

private extension AuthorizationViewController {
    func fetchUserData() {
        self.serviceRead.read(name: "User") { [weak self] (data) -> (Void) in
            guard let self = self else { return }
            self.serviceParsing.parsingArray(jsonData: data) { (user) in
                self.serviceCoreDataOperation.saveUser(user: user)
                self.serviceCoreDataOperation.readUser { (users) in
                    self.userArray = users
                }
            }
        }
    }
}
