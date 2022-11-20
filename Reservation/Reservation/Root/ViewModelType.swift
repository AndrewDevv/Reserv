//
//  ViewModelType.swift
//  Reservation
//
//  Created by Андрей Антонов on 08.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//


protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
