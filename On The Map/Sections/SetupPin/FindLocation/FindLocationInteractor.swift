//
//  FindLocationInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit

class FindLocationInteractor: FindLocationInteractorProtocol {
    func fetchLocationWith(text: String, completion: @escaping (Result<CLLocationCoordinate2D,Error>) -> Void) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(text) { (places, error) in
            guard let placeMarks = places, placeMarks.count > 0 else {
                completion(.failure(GeoCodeError.placeNotFound))
                return
            }
            guard let coordinate = places?.first?.location?.coordinate else {
                completion(.failure(GeoCodeError.placeNotFound))
                return
            }
            completion(.success(coordinate))
        }
    }
}
