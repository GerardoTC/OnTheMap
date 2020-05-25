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
    func createAddPinFlow() -> UINavigationController?
    func createFindMapLocationView(studentLocation: StudentLocation, navigation: UINavigationController) -> FindMapLocationViewController?
}

struct ViewControllersFactory: ViewControllersFactoryProtocol {
    
    func createLoginView() -> LoginViewController? {
        let loginVC: LoginViewController? = createFromStoryBoard(identifier: ViewsConstants.vcs.login)
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
        let rootNav: UINavigationController? = createFromStoryBoard(identifier: ViewsConstants.vcs.rootnav)
        rootNav?.modalPresentationStyle = .fullScreen
        rootNav?.modalTransitionStyle = .crossDissolve
        return rootNav
    }
    
    func createTabsView() -> TabsViewController? {
        let tabBarVC: TabsViewController? = createFromStoryBoard(identifier: ViewsConstants.vcs.tabsvc)
        let router = TabsRouter()
        router.baseViewController = tabBarVC
        router.viewFactory = self
        let presenter = TabsPresenter()
        presenter.view = tabBarVC
        presenter.router = router
        presenter.interactor = TabsInteractor()
        tabBarVC?.presenter = presenter
        return tabBarVC
    }
    
    func createListView() -> LocationListViewController? {
        let locationList: LocationListViewController? = createFromStoryBoard(identifier: ViewsConstants.vcs.locationlist)
        let presenter = LocationListPresenter()
        let router = LocationListRouter()
        let interactor = LocationListInteractor()
        presenter.view = locationList
        locationList?.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        return locationList
    }
    
    func createMapView() -> MapViewController? {
        let mapView: MapViewController? = createFromStoryBoard(identifier: ViewsConstants.vcs.mapView)
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()
        mapView?.presenter = presenter
        presenter.router = router
        presenter.view = mapView
        presenter.interactor = interactor
        return mapView
    }
    
    func createFromStoryBoard<T>(storyBoardName: String = ViewsConstants.storyBoards.main, bundle: Bundle? = nil, identifier: String) -> T? {
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
        mapViewController.tabBarItem.selectedImage = ImagesConstants.mapViewSelected
        mapViewController.tabBarItem.image = ImagesConstants.mapViewDeselected
        listViewController.tabBarItem.selectedImage = ImagesConstants.listViewSelected
        listViewController.tabBarItem.image = ImagesConstants.listViewDeselected
        return rootnavBar
    }
    
    func createAddPinFlow() -> UINavigationController? {
        guard let addPinVC: FindLocationViewController = createFromStoryBoard(storyBoardName: ViewsConstants.storyBoards.setupPin,
                                                                              identifier: ViewsConstants.vcs.findLoc) else {
                                                                                return nil
        }
        
        let nav: UINavigationController? = createFromStoryBoard(storyBoardName: ViewsConstants.storyBoards.setupPin,
                                                                identifier: ViewsConstants.vcs.findLocNav)
        let presenter = FindLocationPresenter()
        let interactor = FindLocationInteractor()
        let router = FindLocationRouter()
        router.navigation = nav
        addPinVC.presenter = presenter
        presenter.view = addPinVC
        presenter.interactor = interactor
        presenter.router = router
        router.viewFactory = self
        nav?.viewControllers = [addPinVC]
        return nav
    }
    
    func createFindMapLocationView(studentLocation: StudentLocation, navigation: UINavigationController) -> FindMapLocationViewController? {
        guard let findMapLocVC: FindMapLocationViewController = createFromStoryBoard(storyBoardName: ViewsConstants.storyBoards.setupPin, bundle: nil, identifier: ViewsConstants.vcs.findMapLoc) else {
            return nil
        }
        let presenter = FindMapLocationPresenter()
        let interactor = FindMapLocationInteractor()
        let router = FindMapLocationRouter()
        findMapLocVC.presenter = presenter
        router.navigationController = navigation
        presenter.view = findMapLocVC
        presenter.interactor = interactor
        presenter.router = router
        presenter.studentLocation = studentLocation
        return findMapLocVC
    }
}
