//
//  NetworkingModels.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

struct Resource<T> {
let url: URL
let parse: (Data) throws -> T
let errorParse: (Data) throws -> GenericResponse
let body: (() throws -> Data)?
}

enum DataError: LocalizedError {
    case noDataError
    case genericError(desc: String, code: Int)
    case unknown
    var errorDescription: String? {
        switch self {
        case .noDataError:
            return "No data returned verify your connection"
        case let .genericError(desc, _):
            return desc
        case .unknown:
            return "Something went wrong pelase try again"
        }
    }
}

struct GenericResponse: Codable {
    var status: Int
    var error: String
}
