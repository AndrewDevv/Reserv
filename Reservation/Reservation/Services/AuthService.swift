//
//  AuthService.swift
//  Reservation
//
//  Created by Андрей Антонов on 08.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import RxSwift
import Firebase

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) -> Observable<Void>
}

final class AuthService: AuthServiceProtocol {
    func signIn(email: String, password: String) -> Observable<Void>  {
        return Observable.create { (observer) in
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    observer.onNext(Void())
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            })
            return Disposables.create()
        }
    }
}
