//
//  LoginInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorProtocol {
    func loginWith(email: String, password: String, result: @escaping (Result<LoginResponse,Error>) -> Void) {
        let resource = createResource(email: email, password: password)
        OTMAPIClient.postRequest(resource: resource, completion: result)
    }
    
    func updateStudentInfo(_ key: String, id: String) {
        StudentAuthInfo.uniqueKey = key
        StudentAuthInfo.id = id
        let parse: (Data) throws -> NSDictionary = { data in
            return try JSONSerialization.jsonObject(with: data,
                                                    options: .allowFragments) as? NSDictionary ?? [:]
        }
        
        let resource = Resource(url: OTMAPIClient.Endpoints.publicUserData(key: key).url,
                                parse: parse,
                                errorParse: OTMAPIClient.genericErrorParse(),
                                body: nil)
        
        OTMAPIClient.getRequest(resource: resource, offsetData: true) { (result) in
            switch result {
            case .success(let dict):
                StudentAuthInfo.firstName = dict["first_name"] as? String ?? String()
                StudentAuthInfo.lastName = dict["last_name"] as? String ?? String()
            case .failure(_):
                break
            }
        }
    }
    
    func createResource(email: String, password: String) -> Resource<LoginResponse> {
        let credentials = UserCredentials(username: email, password: password)
        let loginRequest = LoginRequest(udacity: credentials)
        
        let body = { try JSONEncoder().encode(loginRequest) }
        
        let parse: (Data) throws -> LoginResponse = { data in
            try JSONDecoder().decode(LoginResponse.self, from: data)
        }
        
        return Resource(url: OTMAPIClient.Endpoints.session.url,
                        parse: parse,
                        errorParse: OTMAPIClient.genericErrorParse(),
                        body: body)
    }
    
}

