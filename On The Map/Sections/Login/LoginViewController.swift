//
//  ViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func login() {
        guard let email = emailField.text,
            let password = passwordField.text else {
            return
        }
        presenter.loginWith(email: email, password: password)
    }
    
    @IBAction func signUp() {
        presenter.signUp()
    }
}

//Mark: - Life cycle viewcontroller
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension LoginViewController: LoginViewProtocol {
    func updateErrorText(text: String) {
        errorLabel.text = text
    }
    
    func updateLoading(hide: Bool) {
        loadingIndicator.isHidden = hide
    }
    
    func updateView(_ enable: Bool) {
        emailField.isEnabled = enable
        passwordField.isEnabled = enable
        loginButton.isEnabled = enable
    }
    
    func clearTextFields() {
        emailField.text = String()
        passwordField.text = String()
    }
}
