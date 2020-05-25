//
//  SetupPinProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit

protocol FindLocationPresenterProtocol: class {
    func updateUserInfo(locationText: String, linkText: String)
    func viewDidLoad()
}

protocol FindLocationViewProtocol: class {
    func showAlertError(text: String)
    func setupView()
}

protocol FindLocationInteractorProtocol: class {
    func fetchLocationWith(text: String, completion: @escaping (Result<CLLocationCoordinate2D,Error>) -> Void)
}

protocol FindLocationRouterProtocol: class {
    func routeToMap(studentInfo: StudentLocation)
}
