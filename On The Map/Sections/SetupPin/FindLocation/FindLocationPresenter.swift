//
//  FindLocationPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import UIKit

class FindLocationPresenter: FindLocationPresenterProtocol {
    weak var view: FindLocationViewProtocol!
    var interactor: FindLocationInteractorProtocol!
    var router: FindLocationRouterProtocol!
    
    

    func updateUserInfo(locationText: String, linkText: String) {
        guard !locationText.isEmpty else {
            view.showAlertError(text: FindLocationConstants.locationTextEmpty)
            return
        }
        guard !linkText.isEmpty else{
            view.showAlertError(text: FindLocationConstants.linkTextEmpty)
            return
        }
        guard let url = URL(string: linkText), UIApplication.shared.canOpenURL(url) else {
            view.showAlertError(text: FindLocationConstants.wrongLink)
            return
        }
        interactor.fetchLocationWith(text: locationText) { [unowned self] (result) in
            switch result {
            case .failure(_):
                self.view.showAlertError(text: FindLocationConstants.wrongLocation)
            case .success(let location):
                let student = StudentLocation(uniqueKey: StudentAuthInfo.uniqueKey,
                                              firstName: StudentAuthInfo.firstName,
                                              lastName: StudentAuthInfo.lastName,
                                              mapString: locationText,
                                              mediaURL: linkText,
                                              latitude: location.latitude,
                                              longitude: location.longitude)
                self.router.routeToMap(studentInfo: student)
            }
        }
    }
    
    func viewDidLoad() {
        view.setupView()
    }
    
    
}
