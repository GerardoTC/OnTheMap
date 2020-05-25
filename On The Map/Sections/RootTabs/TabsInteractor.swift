//
//  TabsInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class TabsInteractor: TabsInteractorProtocol {
    func logout(completion: @escaping (Bool) -> Void) {
        OTMAPIClient.deleteSession { (sessionInfo) in
            completion(sessionInfo != nil)
        }
    }
}
