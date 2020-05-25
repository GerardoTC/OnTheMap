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
        let addPinButton = UIBarButtonItem(image: ImagesConstants.addpinImage,
                                        style: .plain,
                                        target: target,
                                        action: addPin)
        let refreshButton = UIBarButtonItem(image: ImagesConstants.refreshImage,
                                            style: .plain,
                                            target: target,
                                            action: refresh)
        
        self.leftBarButtonItem = UIBarButtonItem(title: ExtensionConstants.logout, style: .plain, target: target, action: logout)
        self.rightBarButtonItems = [addPinButton, refreshButton]
    }
}
