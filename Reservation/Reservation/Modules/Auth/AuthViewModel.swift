//
//  AuthViewModel.swift
//  Reservation
//
//  Created by Андрей Антонов on 08.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import RxCocoa
import RxSwift

final class AuthViewModel: ViewModelType {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    struct Input {
        let loginText: Driver<String>
        let passwordText: Driver<String>
        let authButtonTapped: Signal<Void>
    }
    
    struct Output {
        let authResult: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let inputValidUsernameText = input.loginText
            .validationUser()
        let inputValidPasswordText = input.passwordText
            .validationUser()
        let logPass = Signal.combineLatest(
            inputValidUsernameText,
            inputValidPasswordText
        )
        
        let loginResult = input.authButtonTapped
            .withLatestFrom(logPass)
            .asObservable()
            .flatMap { (email, password) -> Observable<Void> in
                AuthService().signIn(email: email, password: password)
            }
        return Output(authResult: loginResult)
    }
}
