//
//  LocationListProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/17/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation


protocol LocationListPresenterProtocol: class {
    func viewDidLoad()
    func numberOfRows() -> Int
    func textForLocation(index: Int) -> String
    func textForUrl(index: Int) -> String
    func selectedLocation(index: Int)
}

protocol LocationListViewProtocol: class {
    func showAlertError(text: String)
    func updateLoading(hide: Bool)
    func reloadView()
}

protocol LocationListInteractorProtocol: class {
    func getLocations(limit: Int, completion: @escaping (Result<[PinAnnotation], Error>) -> Void)
}

protocol LocationListRouterProtocol: class {
    func routeTo(url: URL)
}
