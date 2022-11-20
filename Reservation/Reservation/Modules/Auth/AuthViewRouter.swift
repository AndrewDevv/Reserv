//
//  AuthViewRouter.swift
//  Reservation
//
//  Created by Андрей Антонов on 09.09.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

final class AuthViewRouter {
    func pushView(sourceVC: AuthorizationViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: OfficeChoiceController.self))
        sourceVC.navigationController?.pushViewController(viewController, animated: true)
    }
}
