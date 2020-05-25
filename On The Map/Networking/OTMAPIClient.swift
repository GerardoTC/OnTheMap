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
        case studentLocation(limit: Int)
        case publicUserData(key: String)
        case updateStudentLocation(key: String)
        var stringValue: String {
               switch self {
               case .session:
                return OTMAPIClient.Endpoints.base + "/session"
               case .studentLocation(let limit):
                return OTMAPIClient.Endpoints.base + "/StudentLocation?order=-updatedAt" + "&limit=\(limit)"
               case .publicUserData(let key):
                return OTMAPIClient.Endpoints.base + "/users/\(key)"
               case .updateStudentLocation(let key) :
                return OTMAPIClient.Endpoints.base + "/StudentLocation/\(key)"
               }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func genericErrorParse() -> (Data) throws -> GenericResponse {
        let errorParse: (Data) throws -> GenericResponse = { data in
            try JSONDecoder().decode(GenericResponse.self, from: data)
        }
        return errorParse
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
    
    class func putRequest<A>(resource: Resource<A>, offsetData: Bool = false, completion: @escaping (Result<A, Error>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? resource.body?()
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(
                    Result {
                        guard var newData = data else { throw DataError.noDataError }
                        if offsetData {
                            newData = newData.subdata(in: 5..<newData.count)
                        }
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
    
    @discardableResult
    class func getRequest<A>(resource: Resource<A>, offsetData: Bool = false, completion: @escaping (Result<A,Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(
                    Result {
                        guard var newData = data else { throw DataError.noDataError }
                        if offsetData {
                            newData = newData.subdata(in: 5..<newData.count)
                        }
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
        return task
    }
}
