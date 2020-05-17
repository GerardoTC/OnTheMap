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
        interactor.getLocations(limit: 100) { [weak self](result) in
            switch result {
            case .success(let pins):
                self?.view.add(annotations: pins)
            case .failure(let error):
                self?.view.showAlertError(text: error.localizedDescription)
            }
        }
    }
    
  
}
