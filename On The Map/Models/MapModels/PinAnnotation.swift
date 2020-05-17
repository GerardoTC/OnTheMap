//
//  PinAnnotation.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/17/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit
class PinAnnotation: NSObject, MKAnnotation {
    
      var coordinate: CLLocationCoordinate2D

      var title: String?

      var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
