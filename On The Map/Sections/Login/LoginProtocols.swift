//
//  LoginProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol: class {
    func updateLoading(hide: Bool)
    func updateErrorText(text: String)
    func updateView(_ enable: Bool)
    func clearTextFields()
}

protocol LoginPresenterProtocol: class {
    func viewDidLoad()
    func loginWith(email: String, password: String)
    func signUp()
}

protocol LoginInteractorProtocol: class {
    func loginWith(email: String, password: String, result: @escaping (Result<LoginResponse,Error>) -> Void) 
}

protocol LoginRouterProtocol: class {
    var baseViewController: UIViewController? {get set}
    func routeToMainScreen() 
    func signUp()
}
