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
}

protocol MapViewProtocol: class {
    func add(annotations: [MKAnnotation])
}

protocol MapInteractorProtocol: class {
    
}

protocol MapRouterProtocol: class {
    
}
