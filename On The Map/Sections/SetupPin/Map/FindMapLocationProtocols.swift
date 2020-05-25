//
//  FindMapLocationProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation


import Foundation
import MapKit

protocol FindMapLocationPresenterProtocol: class {
    func viewDidLoad()
    func finishTapped()
}

protocol FindMapLocationViewProtocol: class {
    func showAlertError(text: String)
    func addLocation(location: MKAnnotation)
}

protocol FindMapLocationInteractorProtocol: class {
    func updateInfo(studentInfo: StudentLocation,completion: @escaping (Result<Bool,Error>) -> Void)
}

protocol FindMapLocationRouterProtocol: class {
    func dismissView()
}
