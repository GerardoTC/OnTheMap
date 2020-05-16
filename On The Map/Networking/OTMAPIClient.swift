//
//  UdacityAPIClient.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class OTMAPIClient {
    enum Endpoints {
        static var base = "https://onthemap-api.udacity.com/v1"
        case session
        
        var stringValue: String {
               switch self {
               case .session:
                return OTMAPIClient.Endpoints.base + "/session"
               }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func postRequest<A>(resource: Resource<A>, completion: @escaping (Result<A, Error>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? resource.body?()
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(
                    Result {
                        guard let data = data else { throw DataError.noDataError}
                        let newData = data.subdata(in: 5..<data.count)
                        if let dataParsed = try? resource.parse(newData) {
                            return dataParsed
                        } else {
                            guard let genericError = try? resource.errorParse(newData) else {
                                throw DataError.unknown
                            }
                            throw DataError.genericError(desc: genericError.error, code: genericError.status)
                        }
                    }
                )
            }
           
        }
        task.resume()
    }
}
