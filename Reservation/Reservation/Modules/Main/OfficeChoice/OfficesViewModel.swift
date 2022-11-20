//
//  OfficesViewModel.swift
//  Reservation
//
//  Created by Андрей Антонов on 09.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import RxSwift
import RxCocoa

final class OfficesViewModel {
    
    struct Output {
        let result: Observable<[Office]>
    }

    func transform() -> Output {
        let result = ServiceDownloadData().requestOffice()
        return Output(result: result)
    }
}
