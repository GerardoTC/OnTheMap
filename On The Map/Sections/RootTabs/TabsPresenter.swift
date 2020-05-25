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
    var interactor: TabsInteractor!
    func viewDidLoad() {
        view.setUpView()
    }
    
    func addPinTapped() {
        router.routeToAddPin()
    }
    
    func logoutTapped() {
        interactor.logout { [unowned self ] (_) in
            self.router.routeToLogout()
        }
        
    }
    
    func refreshTapped() {
        view.currentRefreshableView()?.refreshView()
    }
    
}
