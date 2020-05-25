//
//  StudentInfoRequest.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/19/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

struct StudentLocation: Encodable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}

class StudentAuthInfo {
    static var uniqueKey: String = String()
    static var id: String = String()
    static var firstName: String = String()
    static var lastName: String = String()
}
