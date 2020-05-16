//
//  UINavigtionControllerExtensions.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    func addBarButtons(target: Any?, addPin: Selector?, refresh: Selector?, logout: Selector?) {
        let addPinButton = UIBarButtonItem(image: UIImage(named: "add_pin_icon"),
                                        style: .plain,
                                        target: target,
                                        action: addPin)
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh_icon"),
                                            style: .plain,
                                            target: target,
                                            action: refresh)
        
        self.leftBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: target, action: logout)
        self.rightBarButtonItems = [addPinButton, refreshButton]
    }
}
