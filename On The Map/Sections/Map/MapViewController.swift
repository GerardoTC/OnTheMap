//
//  MapViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    var presenter: MapPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension MapViewController: MapViewProtocol {
    func add(annotations: [MKAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
}

extension MapViewController: RefreshableViewController {
    func refreshView() {
        presenter.viewDidLoad()
    }
    
    func showAlertError(text: String) {
        print(text)
    }
}
private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

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
