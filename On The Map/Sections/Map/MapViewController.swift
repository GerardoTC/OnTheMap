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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
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
    func showAlertError(text: String) {
        let alert = UIAlertController(title: "Oops...", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let view = mapView.dequeueReusableAnnotationView(withIdentifier: "IdentifierAnnotation") as? MKMarkerAnnotationView else {
            let newView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "IdentifierAnnotation")
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

