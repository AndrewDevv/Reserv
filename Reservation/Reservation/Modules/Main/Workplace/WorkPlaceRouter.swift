//
//  WorkPlaceRouter.swift
//  Reservation
//
//  Created by Андрей Антонов on 23.10.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

final class WorkplaceRouter {
    func pushWorkplace(sourceVC: WorkPlaceViewController) {
        let viewController = ChooseDateVC()
        sourceVC.navigationController?.pushViewController(viewController, animated: true)
    }
}
