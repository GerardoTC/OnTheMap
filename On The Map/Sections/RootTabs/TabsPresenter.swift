//
//  TabsPresenter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class TabsPresenter: TabsPresenterProtocol {
    weak var view: TabsViewProtocol!
    var router: TabsRouterProtocol!
    func viewDidLoad() {
        view.setUpView()
    }
    
    func addPinTapped() {
        router.routeToAddPin()
    }
    
    func logoutTapped() {
        router.routeToLogout()
    }
    
    func refreshTapped() {
        view.currentRefreshableView()?.refreshView()
    }
    
}
