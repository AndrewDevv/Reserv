//
//  ServiceReadJSON.swift
//  Reservation
//
//  Created by Андрей Антонов on 12.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift

enum ReadFileError: Error {
    case failedToRead
}

final class ServiceReadJSON{
    func read(name: String, closure: @escaping (Data) -> (Void)) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                closure(jsonData)
            }
        } catch {
            print(error)
        }
    }
    func readFiles(name: String) -> Observable<Data> {
        return Observable.create { observer in
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
                observer.onNext(jsonData!)
                observer.onCompleted()
            } else {
                observer.onError(ReadFileError.failedToRead)
            }
            return Disposables.create()
        }
    }
}
