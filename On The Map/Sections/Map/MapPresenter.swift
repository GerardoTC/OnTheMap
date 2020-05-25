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
        interactor.getLocations(limit: MapViewConstants.limit) { [weak self](result) in
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
                let annotationString = (annotation.title ?? String()) ?? MapViewConstants.pinText
                self.view.showAlertError(text: MapViewConstants.invalidUrl
                                            + annotationString
                                            + MapViewConstants.invalidLink)
            return
        }
        router.routeTo(url: url)
    }
  
}
