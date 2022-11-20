//
//  User.swift
//  Reservation
//
//  Created by Андрей Антонов on 05.10.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation

struct User: Decodable {
    var firstName: String
    var lastName: String
    var country: String
    var city: String
    var yearOfBrith: Int32
    var pet: Pet
    var numbers: [Numbers]
    
    enum CodingKeys:String, CodingKey {
        case firstName, lastName, country, city, pet, numbers
        case yearOfBrith = "year_of_brith"
    }
    
    struct Pet: Decodable {
        var name: String
        var color: String
        var legs: Int32
        var eye: Int32
    }
    
    struct Numbers: Decodable {
        var personalNumber: Int32
        var homeNumber: Int32
    }
}
