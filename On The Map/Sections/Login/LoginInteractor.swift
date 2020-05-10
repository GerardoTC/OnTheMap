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
    
    func createResource(email: String, password: String) -> Resource<LoginResponse> {
        let credentials = UserCredentials(username: email, password: password)
        let loginRequest = LoginRequest(udacity: credentials)
        
        let body = { try JSONEncoder().encode(loginRequest) }
        
        let parse: (Data) throws -> LoginResponse = { data in
            try JSONDecoder().decode(LoginResponse.self, from: data)
        }
        
        let errorParse: (Data) throws -> GenericResponse = { data in
            try JSONDecoder().decode(GenericResponse.self, from: data)
        }
        return Resource(url: OTMAPIClient.Endpoints.session.url,
                        parse: parse,
                        errorParse: errorParse,
                        body: body)
    }
    
}

