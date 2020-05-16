//
//  TabsViewController.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addBarButtons(target: self,
                                     addPin: #selector(addNewPin),
                                     refresh: #selector(refreshView),
                                     logout: #selector(logout))
        navigationItem.title = "On The Map"
    }
    
    @objc
    func addNewPin() {
        print("AddPin")
    }
    
    @objc
    func refreshView() {
        print("Refresh")
    }
    
    @objc
    func logout() {
        print("Logout")
    }
}
