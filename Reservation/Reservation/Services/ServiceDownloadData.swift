//
//  ServiceDownloadData.swift
//  Reservation
//
//  Created by Андрей Антонов on 27.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import RxSwift

protocol OfficeDownloader {
    func requestOffice() -> Observable<[Office]>
    
    func requestRooms() -> Observable<[RoomsJSON]>
    
    func serviceWorkplace() -> Observable<[WorkPlace]>
}

final class ServiceDownloadData: OfficeDownloader {
    private let serviceRequestData = ServiceRequestData()
    private let serviceParsingJSON = ServiceParsingJSON()
    
    private let urlOffices = "https://firebasestorage.googleapis.com/v0/b/reservation-9598e.appspot.com/o/OfficeChoiceJSON.json?alt=media&token=fdc22193-03c8-40b5-a30f-db6caaeb3adf"
    private let urlRooms = "https://firebasestorage.googleapis.com/v0/b/reservation-9598e.appspot.com/o/Rooms.json?alt=media&token=0376746b-c3d6-439b-a095-3c3ba85dc119"
    private let urlWorkplaces = "https://firebasestorage.googleapis.com/v0/b/reservation-9598e.appspot.com/o/Workplace.json?alt=media&token=5b879bc2-e342-4496-a8bd-0993f63a4e2a"
    
    func requestOffice() -> Observable<[Office]> {
        return serviceRequestData.requestData(url: urlOffices)
            .flatMap { data in
                self.serviceParsingJSON.parseArray(jsonData: data)
        }
    }
    
    func requestRooms() -> Observable<[RoomsJSON]> {
        return serviceRequestData.requestData(url: urlRooms)
            .flatMap { (data) in
                self.serviceParsingJSON.parseArray(jsonData: data)
        }
    }
    
    func serviceWorkplace() -> Observable<[WorkPlace]> {
        return serviceRequestData.requestData(url: urlWorkplaces)
            .flatMap { (data) in
                self.serviceParsingJSON.parseArray(jsonData: data)
        }
    }
}
