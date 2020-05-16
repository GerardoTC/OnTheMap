//
//  MapPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewProtocol!
    var router: MapRouterProtocol!
    var interactor: MapInteractorProtocol!
    func viewDidLoad() {
        
    }
}
