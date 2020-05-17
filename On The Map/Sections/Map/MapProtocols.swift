//
//  MapProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit

protocol MapPresenterProtocol: class {
    func viewDidLoad()
    func annotationTapped(annotation: MKAnnotation)
}

protocol MapViewProtocol: class {
    func add(annotations: [MKAnnotation])
    func showAlertError(text: String)
    func updateLoading(hide: Bool)
}

protocol MapInteractorProtocol: class {
    func getLocations(limit: Int, completion: @escaping (Result<[PinAnnotation], Error>) -> Void)
}

protocol MapRouterProtocol: class {
    func routeTo(url: URL)
}
