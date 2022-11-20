//
//  WorkplaceViewModel.swift
//  Reservation
//
//  Created by Андрей Антонов on 15.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class WorkplaceViewModel {
    struct Output {
        let result: Observable<[WorkPlace]>
    }
    
    func transform() -> Output {
        let result = ServiceDownloadData().serviceWorkplace()
        return Output(result: result)
    }
}
