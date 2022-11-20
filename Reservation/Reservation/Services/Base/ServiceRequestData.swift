//
//  ServiceRequestData.swift
//  Reservation
//
//  Created by Андрей Антонов on 27.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class ServiceRequestData {
    func requestData(url: String) -> Observable<Data> {
        return Observable.create { (observer) in
            Alamofire.request(url).responseJSON { (response) in
                if let data = response.data {
                    observer.onNext(data)
                    observer.onCompleted()
                } else {
                    if let error = response.error {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
