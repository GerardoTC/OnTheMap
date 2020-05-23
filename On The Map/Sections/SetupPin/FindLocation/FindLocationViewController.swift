//
//  SetupPinViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class FindLocationViewController: UIViewController {
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    var presenter: FindLocationPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        addCancelButton()
    }
    
    @IBAction func findLocationTapped() {
        guard let locationString = locationText.text,
            let linkString = linkText.text else {
                return
        }
        presenter.updateUserInfo(locationText: locationString,
                                     linkText: linkString)
    }
}

extension FindLocationViewController: FindLocationViewProtocol { }
