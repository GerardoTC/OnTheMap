//
//  FindMapLocationRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit
class FindMapLocationRouter: FindMapLocationRouterProtocol {
    var navigationController: UINavigationController!
    
    func dismissView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
