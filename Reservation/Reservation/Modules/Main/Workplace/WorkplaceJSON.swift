//
//  WorkPlaceJSON.swift
//  Reservation
//
//  Created by Андрей Антонов on 25.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation

struct WorkPlace: Decodable {
    var name: String
    var number: String
    var isAvailable: Bool
}
