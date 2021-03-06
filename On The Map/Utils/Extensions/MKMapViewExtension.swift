//
//  MKMapViewExtension.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/17/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
  func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
