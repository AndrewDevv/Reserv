//
//  RoomsViewModel.swift
//  Reservation
//
//  Created by Андрей Антонов on 15.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RoomsViewModel {
    struct Output {
        let result: Observable<[RoomsJSON]>
    }
    
    func transform() -> Output {
        let result = ServiceDownloadData().requestRooms()
        return Output(result: result)
    }
}
