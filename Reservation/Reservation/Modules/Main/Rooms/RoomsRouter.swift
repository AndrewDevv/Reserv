//
//  OfficeRouter.swift
//  Reservation
//
//  Created by Андрей Антонов on 15.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

final class RoomsRouter {
    func pushRooms(sourceVC: RoomsViewController) {
        let workplace = WorkPlaceViewController()
        sourceVC.navigationController?.pushViewController(workplace, animated: true)
    }
}
