//
//  FindLocationRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit
class FindLocationRouter: FindLocationRouterProtocol {
    var navigation: UINavigationController!
    var viewFactory: ViewControllersFactoryProtocol?
    
    func routeToMap(studentInfo: StudentLocation) {
        guard let vc = viewFactory?.createFindMapLocationView(studentLocation: studentInfo ,navigation: navigation) else {
            return
        }
        navigation.pushViewController(vc, animated: true)
    }

}
