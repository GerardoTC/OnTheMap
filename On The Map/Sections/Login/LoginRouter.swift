//
//  LoginRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
    
    var baseViewController: UIViewController?
    var viewFactory: ViewControllersFactoryProtocol!
    
    func routeToMainScreen() {
        guard let tabView = viewFactory.createTabsView(),
            let rootnavBar = viewFactory.createRootNavView(),
            let mapViewController = viewFactory.createMapView(),
            let listViewController = viewFactory.createListView() else {
            return
        }
        rootnavBar.viewControllers = [tabView]
        tabView.viewControllers = [mapViewController, listViewController]
        mapViewController.tabBarItem.selectedImage = UIImage(named: "mapview_selected_icon")
        mapViewController.tabBarItem.image = UIImage(named: "mapview_deselected_icon")
        listViewController.tabBarItem.selectedImage = UIImage(named: "listview-selected_icon")
        listViewController.tabBarItem.image = UIImage(named: "listview-deselected_icon")
        baseViewController?.present(rootnavBar, animated: true, completion: nil)
    }
    
    func signUp() {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }
}
