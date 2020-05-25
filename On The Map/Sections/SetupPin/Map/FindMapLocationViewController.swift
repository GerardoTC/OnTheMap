//
//  FindMapLocationViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/23/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit
import MapKit

class FindMapLocationViewController: UIViewController {
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var presenter: FindMapLocationPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func finishTapped() {
        presenter.finishTapped()
    }
}

extension FindMapLocationViewController: FindMapLocationViewProtocol {
    func addLocation(location: MKAnnotation) {
        map.addAnnotation(location)
        map.centerToLocation(location.coordinate)
    }
}

