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
    
    func routeToMainScreen() {
        let rootNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavController")
        rootNav.modalPresentationStyle = .fullScreen
        rootNav.modalTransitionStyle = .crossDissolve
        baseViewController?.present(rootNav, animated: true, completion: nil)
    }
    
    func signUp() {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }
}
extension LoginRouterProtocol {
    static func createLoginView() -> LoginViewController? {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")  as? LoginViewController
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        router.baseViewController = loginVC
        presenter.interactor = interactor
        presenter.router = router
        loginVC?.presenter = presenter
        presenter.view = loginVC
        return loginVC
    }
    
}
