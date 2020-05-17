//
//  MapRouter.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

class MapRouter: MapRouterProtocol {
    func routeTo(url: URL) {
        UIApplication.shared.open(url)
    }
}
