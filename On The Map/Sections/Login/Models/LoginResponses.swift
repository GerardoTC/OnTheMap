//
//  LoginResponses.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var account: AccountInfo
    var session: SessionInfo
}

struct AccountInfo: Codable {
    var registered: Bool
    var key: String
}

struct SessionInfo: Codable {
    var id: String
    var expiration: String
}

struct GenericResponse: Codable {
    var status: Int
    var error: String
}
