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
        case postStudentLocation
        case updateStudentLocation(objectId: String)
        case signUp
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
               case .postStudentLocation:
                return OTMAPIClient.Endpoints.base + "/StudentLocation"
               case .signUp:
                return "https://auth.udacity.com/sign-up"
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
    
    class func postRequest<A>(resource: Resource<A>, offsetData: Bool = false, completion: @escaping (Result<A, Error>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = ClientConstants.httpMethod.post
        request.addValue(ClientConstants.requestContent.applicationJson,
                         forHTTPHeaderField: ClientConstants.requestContent.accept)
        request.addValue(ClientConstants.requestContent.applicationJson,
                         forHTTPHeaderField: ClientConstants.requestContent.contentType)
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
    
    class func putRequest<A>(resource: Resource<A>, offsetData: Bool = false, completion: @escaping (Result<A, Error>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = ClientConstants.httpMethod.put
        request.addValue(ClientConstants.requestContent.applicationJson,
                         forHTTPHeaderField: ClientConstants.requestContent.contentType)
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
    
    class func deleteSession(completion: @escaping (SessionRoot?) -> Void) {
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = ClientConstants.httpMethod.delete
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name ==  ClientConstants.requestContent.xsrf { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: ClientConstants.requestContent.xxsrf)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil)
                    return
                }
                let newData = data.subdata(in: 5..<data.count)
                let resultSession = try? JSONDecoder().decode(SessionRoot.self, from: newData)
                completion(resultSession)
            }
            
        }
        task.resume()
    }
}
