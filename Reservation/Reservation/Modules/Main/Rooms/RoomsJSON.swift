//
//  RoomsAndWorkJSON.swift
//  Reservation
//
//  Created by Андрей Антонов on 02.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation

struct RoomsJSON: Decodable {
    var name: String
    var isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case isAvailable = "is_available"
    }
}
