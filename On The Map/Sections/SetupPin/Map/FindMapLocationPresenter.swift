//
//  FindMapLocationPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit
class FindMapLocationPresenter: FindMapLocationPresenterProtocol {
    var studentLocation: StudentLocation!
    var interactor: FindMapLocationInteractorProtocol!
    weak var view: FindMapLocationViewProtocol!
    var router: FindMapLocationRouterProtocol!
    
    func viewDidLoad() {
        let location = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        let annotation = PinAnnotation(coordinate: location, title: studentLocation.mapString)
        view.addLocation(location: annotation)
        view.updateLoading(hide: true)
    }
    
    func finishTapped() {
        view.updateLoading(hide: false)
        interactor.updateInfo(studentInfo: studentLocation) { [unowned self] result in
            self.view.updateLoading(hide: true)
            switch result {
            case .success(_):
                self.router.dismissView()
            case .failure(let error):
                self.view.showAlertError(text: error.localizedDescription)
            }
        }
    }

}
