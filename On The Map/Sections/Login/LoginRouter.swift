//
//  LoginRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
    
    var baseViewController: UIViewController?
    var viewFactory: ViewControllersFactoryProtocol!
    
    func routeToMainScreen() {
        guard let rootnavBar = viewFactory.createMainScreen() else {
            return
        }
        baseViewController?.present(rootnavBar, animated: true, completion: nil)
    }
    
    func signUp() {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }
}
