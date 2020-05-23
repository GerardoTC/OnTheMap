//
//  LoginPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol!
    var interactor: LoginInteractorProtocol!
    var router: LoginRouterProtocol!
    
    func viewDidLoad() {
        view.updateLoading(hide: true)
    }
    
    func loginWith(email: String, password: String) {
        guard isValidEmail(email) else {
            view.updateErrorText(text: LoginConstants.emailError)
            return
        }
        guard !password.isEmpty else {
            view?.updateErrorText(text: LoginConstants.emptyPassword)
            return
        }
        view.updateErrorText(text: String())
        view.updateLoading(hide: false)
        view.updateView(false)
        interactor?.loginWith(email: email, password: password, result: handleLoginResponse(result:))
    }
    
    func handleLoginResponse(result: (Result<LoginResponse, Error>)) {
        view?.updateLoading(hide: true)
        view?.updateView(true)
        switch result {
        case .success(let response):
//            view.clearTextFields()
            interactor.updateStudentInfo(response.account.key)
            router.routeToMainScreen()
        case .failure(let error):
            view.updateErrorText(text: error.localizedDescription)
        }
    }
    
    func signUp() {
        router.signUp()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
