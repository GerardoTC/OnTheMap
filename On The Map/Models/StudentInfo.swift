//
//  StudentInfo.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/17/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

import Foundation
import MapKit
struct StudentInfo: Decodable {
    var createdAt: Date?
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: URL?
    var objectId: String
    var uniqueKey: String
    var updatedAt: Date?
    var location: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case firstName
        case mapString
        case mediaURL
        case objectId
        case uniqueKey
        case updatedAt
        case latitude
        case longitude
        case lastName
    }
    
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = dateFormatter.date(from: try container.decode(String.self, forKey: .createdAt))
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.mapString = try container.decode(String.self, forKey: .mapString)
        self.mediaURL = URL(string: try container.decode(String.self, forKey: .mediaURL))
        self.objectId = try container.decode(String.self, forKey: .objectId)
        self.uniqueKey = try container.decode(String.self, forKey: .uniqueKey)
        self.updatedAt = dateFormatter.date(from: try container.decode(String.self, forKey: .updatedAt))
        self.location = CLLocationCoordinate2DMake(try container.decode(Double.self, forKey: .latitude),
                                                   try container.decode(Double.self, forKey: .longitude))
    }
}

struct StudentsInfo: Decodable {
    var results: [StudentInfo]
}
