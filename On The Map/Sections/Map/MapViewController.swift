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
        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.centerToLocation(initialLocation)
        let pin = PinAnnotation(coordinate: CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444), title: "Honolulu paark", subtitle: "No subtitle for this")
        let annotation = MKAnnotationView(annotation: pin, reuseIdentifier: "1")
//        MKPinAnnotationView(annotation: MKAnnotation?, reuseIdentifier: <#T##String?#>)
    }

}

extension MapViewController: MapViewProtocol {
    func add(annotations: [MKAnnotation]) {
        
    }
}

extension MapViewController: RefreshableViewController {
    func refreshView() {
        print("Refresh")
    }
}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
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