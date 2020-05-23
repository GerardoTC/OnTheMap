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
    var viewFactory: ViewControllersFactoryProtocol?
    func routeToAddPin() {
        guard let nav = viewFactory?.createAddPinFlow() else {
            return
        }
        baseViewController?.present(nav, animated: true, completion: nil)
    }
    
    func routeToLogout() {
        baseViewController?.dismiss(animated: true, completion: nil)
    }
    
}
