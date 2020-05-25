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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: MapPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        mapView.delegate = self
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
    
    func updateLoading(hide: Bool) {
        self.activityIndicator.isHidden = hide
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let view = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewConstants.annotationId) as? MKMarkerAnnotationView else {
            let newView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MapViewConstants.annotationId)
            newView.canShowCallout = true
            newView.calloutOffset = CGPoint(x: -1, y: 1)
            newView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return newView
        }
        view.annotation = annotation
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else {
            return
        }
        presenter.annotationTapped(annotation: annotation)
    }
}

