//
//  MapPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewProtocol!
    var router: MapRouterProtocol!
    var interactor: MapInteractorProtocol!
    
    func viewDidLoad() {
        view.updateLoading(hide: false)
        interactor.getLocations(limit: 100) { [weak self](result) in
            self?.view.updateLoading(hide: true)
            switch result {
            case .success(let pins):
                self?.view.add(annotations: pins)
            case .failure(let error):
                self?.view.showAlertError(text: error.localizedDescription)
            }
        }
    }
    
    func annotationTapped(annotation: MKAnnotation) {
        guard let subtitle = annotation.subtitle,
            let urlString = subtitle,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
                self.view.showAlertError(text: "Invalid Url found, sorry but \((annotation.title ?? String()) ?? "the pin") has an invalid link")
            return
        }
        router.routeTo(url: url)
    }
  
}
