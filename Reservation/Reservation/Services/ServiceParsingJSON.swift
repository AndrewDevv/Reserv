//
//  ServiceParsingJSON.swift
//  Reservation
//
//  Created by Андрей Антонов on 29.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import RxSwift

enum ParsingError: Error {
    case couldNotParse
}

final class ServiceParsingJSON {
    func parseArray<T: Decodable>(jsonData: Data) -> Observable<[T]> {
        return Observable.create { observer in
            if let decodedData = try? JSONDecoder().decode([T].self, from: jsonData) {
                observer.onNext(decodedData)
                observer.onCompleted()
            } else {
                observer.onError(ParsingError.couldNotParse)
            }
            return Disposables.create()
        }
    }
    
    func parse<T: Decodable>(jsonData: Data) -> Observable<T> {
        return Observable.create { (observer) in
            if let decodedData = try? JSONDecoder().decode(T.self, from: jsonData) {
                observer.onNext(decodedData)
                observer.onCompleted()
            } else {
                observer.onError(ParsingError.couldNotParse)
            }
            return Disposables.create()
        }
    }
}

final class ServiceParse<T: Decodable> {
    func parsingArray(jsonData: Data, onFinish: @escaping ([T]) -> Void) {
        do {
            let decodeData = try JSONDecoder().decode([T].self, from: jsonData)
            onFinish(decodeData)
        } catch {
            print("decode error")
        }
    }
}
