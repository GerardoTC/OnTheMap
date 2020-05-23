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
}

protocol FindLocationViewProtocol: class {
    func showAlertError(text: String)
}

protocol FindLocationInteractorProtocol: class {
    func fetchLocationWith(string: String, completion: (Result<CLLocationCoordinate2D,Error>) -> Void)
}

protocol FindLocationRouterProtocol: class {
    func routeToMap(studentInfo: StudentLocation)
}