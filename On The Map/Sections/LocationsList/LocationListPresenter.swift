//
//  LocationListPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/17/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class LocationListPresenter: LocationListPresenterProtocol {
    weak var view: LocationListViewProtocol!
    var interactor: LocationListInteractorProtocol!
    var router: LocationListRouterProtocol!
    var pinAnotations: [PinAnnotation]?
    
    func viewDidLoad() {
        view.updateLoading(hide: false)
        interactor.getLocations(limit: LocationListConstants.limit) { (result) in
            self.view.updateLoading(hide: true)
            switch result {
            case .failure(let error):
                self.view.showAlertError(text: error.localizedDescription)
            case .success(let pins):
                self.pinAnotations = pins
                self.view.reloadView()
            }
        }
    }
    
    func numberOfRows() -> Int {
        pinAnotations?.count ?? 0
    }
    
    func textForLocation(index: Int) -> String {
        guard index <= pinAnotations?.count ?? 0 - 1 else { return String() }
        guard let title = pinAnotations?[index].title else {return String()}
        return title
    }
    
    func textForUrl(index: Int) -> String {
        guard index <= pinAnotations?.count ?? 0 - 1 else { return String() }
        guard let subtitle = pinAnotations?[index].subtitle else {return String()}
        return subtitle
    }
    
    func selectedLocation(index: Int) {
        guard index <= pinAnotations?.count ?? 0 - 1,
            let urlString = pinAnotations?[index].subtitle,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
                
                view.showAlertError(text: LocationListConstants.invalidUrl
                                    + (pinAnotations?[index].title ?? LocationListConstants.pinText)
                                    + LocationListConstants.invalidLink)
                return
        }
        router.routeTo(url: url)
    }
    
    
}
