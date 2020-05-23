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
            view.showAlertError(text: "Location text is empty please enter a valid text")
            return
        }
        guard !linkText.isEmpty else{
            view.showAlertError(text: "Link text is empty please enter a valid text")
            return
        }
        guard let url = URL(string: linkText), UIApplication.shared.canOpenURL(url) else {
            view.showAlertError(text: "The Link provided can't be handled please try with a different one")
            return
        }
        interactor.fetchLocationWith(string: locationText) { (result) in
            switch result {
            case .failure(_):
                view.showAlertError(text: "The location could'nt be founded please add some info to the location field")
            case .success(let location):
                let student = StudentLocation(uniqueKey: StudentAuthInfo.uniqueKey,
                                              firstName: StudentAuthInfo.firstName,
                                              lastName: StudentAuthInfo.lastName,
                                              mapString: locationText,
                                              mediaURL: linkText,
                                              latitude: location.latitude,
                                              longitude: location.longitude)
                router.routeToMap(studentInfo: student)
            }
        }
    }
    
    
}
