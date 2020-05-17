//
//  ViewControllersFactory.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllersFactoryProtocol {
    func createLoginView() -> LoginViewController?
    func createRootNavView() -> UINavigationController?
    func createTabsView() -> TabsViewController?
    func createListView() -> LocationListViewController?
    func createMapView() -> MapViewController?
    func createMainScreen() -> UIViewController?
}

struct ViewControllersFactory: ViewControllersFactoryProtocol {
    
    func createLoginView() -> LoginViewController? {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")  as? LoginViewController
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        router.baseViewController = loginVC
        router.viewFactory = self
        presenter.interactor = interactor
        presenter.router = router
        loginVC?.presenter = presenter
        presenter.view = loginVC
        return loginVC
    }
    
    
    func createRootNavView() -> UINavigationController? {
        let rootNav: UINavigationController? = createFromStoryBoard(identifier: "RootNavController")
        rootNav?.modalPresentationStyle = .fullScreen
        rootNav?.modalTransitionStyle = .crossDissolve
        return rootNav
    }
    
    func createTabsView() -> TabsViewController? {
        let tabBarVC: TabsViewController? = createFromStoryBoard(identifier: "TabsViewController")
        let router = TabsRouter()
        router.baseViewController = tabBarVC
        let presenter = TabsPresenter()
        presenter.view = tabBarVC
        presenter.router = router
        tabBarVC?.presenter = presenter
        return tabBarVC
    }
    
    func createListView() -> LocationListViewController? {
        let locationList: LocationListViewController? = createFromStoryBoard(identifier: "LocationListViewController")
        
        return locationList
    }
    
    func createMapView() -> MapViewController? {
        let mapView: MapViewController? = createFromStoryBoard(identifier: "MapViewController")
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()
        mapView?.presenter = presenter
        presenter.router = router
        presenter.view = mapView
        presenter.interactor = interactor
        return mapView
    }
    
    func createFromStoryBoard<T>(storyBoardName: String = "Main", bundle: Bundle? = nil, identifier: String) -> T? {
        guard let viewCreated = UIStoryboard(name: storyBoardName, bundle: bundle).instantiateViewController(withIdentifier: identifier) as? T else {
            return nil
        }
        return viewCreated
    }
    
    func createMainScreen() -> UIViewController? {
        guard let tabView = createTabsView(),
            let rootnavBar = createRootNavView(),
            let mapViewController = createMapView(),
            let listViewController = createListView() else {
            return nil
        }
        rootnavBar.viewControllers = [tabView]
        tabView.viewControllers = [mapViewController, listViewController]
        mapViewController.tabBarItem.selectedImage = UIImage(named: "mapview_selected_icon")
        mapViewController.tabBarItem.image = UIImage(named: "mapview_deselected_icon")
        listViewController.tabBarItem.selectedImage = UIImage(named: "listview-selected_icon")
        listViewController.tabBarItem.image = UIImage(named: "listview-deselected_icon")
        return rootnavBar
    }
}
