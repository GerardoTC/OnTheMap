//
//  TabsProtocols.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

protocol TabsPresenterProtocol: class {
    func viewDidLoad()
    func addPinTapped()
    func logoutTapped()
    func refreshTapped()
}

protocol TabsRouterProtocol: class {
    var baseViewController: UIViewController? {get set}
    func routeToAddPin()
    func routeToLogout()
}

protocol TabsViewProtocol: class {
    func currentRefreshableView() -> RefreshableViewController?
    func setUpView()
}

protocol RefreshableViewController {
    func refreshView()
}
