//
//  FindMapLocationInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class FindMapLocationInteractor: FindMapLocationInteractorProtocol {
    func updateInfo(studentInfo: StudentLocation, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let parse: (Data) throws -> String = { data in
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            guard let updated =  dict?["updatedAt"] as? String else {
                throw DataError.noDataError
            }
            return updated
        }
        
        let body = {
            try JSONEncoder().encode(studentInfo)
        }
        
        let resource = Resource(url: OTMAPIClient.Endpoints.updateStudentLocation(key: StudentAuthInfo.uniqueKey).url,
                                parse: parse,
                                errorParse: OTMAPIClient.genericErrorParse(),
                                body: body)
        
        OTMAPIClient.putRequest(resource: resource) { (result) in
            switch result {
            case .success(let result):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
