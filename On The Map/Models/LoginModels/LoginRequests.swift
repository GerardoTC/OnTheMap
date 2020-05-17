//
//  LoginRequests.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    var udacity: UserCredentials
}

struct UserCredentials: Codable {
    var username: String
    var password: String
}
