//
//  TabsViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {
    var presenter: TabsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @objc
    func addNewPin() {
        presenter?.addPinTapped()
    }
    
    @objc
    func refreshView() {
        presenter?.refreshTapped()
    }
    
    @objc
    func logout() {
        presenter?.logoutTapped()
    }
}

extension TabsViewController: TabsViewProtocol {
    func currentRefreshableView() -> RefreshableViewController? {
        return tabBarController?.selectedViewController as? RefreshableViewController
    }
    
    func setUpView() {
        navigationItem.addBarButtons(target: self,
                                     addPin: #selector(addNewPin),
                                     refresh: #selector(refreshView),
                                     logout: #selector(logout))
        navigationItem.title = "On The Map"
    }
    
    
}
