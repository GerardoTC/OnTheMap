//
//  TabsRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class TabsRouter: TabsRouterProtocol {
    var baseViewController: UIViewController?
    
    func routeToAddPin() {

    }
    
    func routeToLogout() {
        baseViewController?.dismiss(animated: true, completion: nil)
    }
    
}
