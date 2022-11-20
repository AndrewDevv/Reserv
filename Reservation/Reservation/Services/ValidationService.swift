//
//  ValidationService.swift
//  Reservation
//
//  Created by Андрей Антонов on 16.11.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import RxCocoa

//enum ValidationError: Error {
//    case invalidValue
//    case userNameTooShort
//    case userNameTooLong
//    case passwordTooShort
//    case passwordTooLong
//}

extension SharedSequence where Element == String, SharingStrategy == DriverSharingStrategy {
    
    func validationUser(min: Int = 3, max: Int = 20) -> Signal<String> {
        return filter { $0.count >= min }
            .filter { $0.count < max }
            .asSignal(onErrorJustReturn: "error")
    }
}

//protocol ValidationServiceProtocol {
//    func validationUsername(username: String?) throws -> String
//    func validationPassword(password: String?) throws -> String
//}
//
//struct ValidationService: ValidationServiceProtocol {
//    func validationUsername(username: String?) throws -> String {
//        guard let username = username else { throw
//            ValidationError.invalidValue
//        }
//
//        guard username.count > 3 else { throw
//            ValidationError.userNameTooShort
//        }
//
//        guard username.count < 20 else { throw
//            ValidationError.userNameTooLong
//        }
//
//        return username
//    }
//
//    func validationPassword(password: String?) throws -> String {
//        guard let password = password else { throw
//            ValidationError.invalidValue
//        }
//
//        guard password.count >= 8 else { throw
//            ValidationError.passwordTooShort
//        }
//
//        guard password.count < 20 else { throw
//            ValidationError.passwordTooLong
//        }
//
//        return password
//    }
//}

//extension SharedSequence {
//
//    func debounce(_ interval: RxTimeInterval, if closure: @escaping (Element) -> Bool) -> SharedSequence<SharingStrategy, Element> {
//        return flatMapLatest {
//            if !closure($0) {
//                return SharedSequence<SharingStrategy, Element> .just($0)
//            }
//            return SharedSequence<SharingStrategy, Int>.timer(interval, period: .seconds(5000)).mapTo($0)
//        }
//    }
//}
