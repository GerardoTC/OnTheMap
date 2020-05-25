//
//  FindMapLocationInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/24/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class FindMapLocationInteractor: FindMapLocationInteractorProtocol {
    func updateInfo(studentInfo: StudentLocation, completion: @escaping (Result<Void, Error>) -> Void) {
        
        if StudentAuthInfo.objectID != "" {
            updateStudentInfo(studentInfo, completion:  completion)
        } else {
            postAndUpdateStudentInfo(studentInfo, completion: completion)
        }
        
    }
    
    func postAndUpdateStudentInfo(_ studentInfo: StudentLocation, completion: @escaping (Result<Void, Error>) -> Void)  {
        
        let parse: (Data) throws -> String = { data in
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            guard let objectId: String = dict?[DictionaryIds.objectId] as? String else {
                throw DataError.noDataError
            }
            return objectId
        }
        let body = {
            try JSONEncoder().encode(studentInfo)
        }
        let resource = Resource(url: OTMAPIClient.Endpoints.postStudentLocation.url,
                                parse: parse,
                                errorParse: OTMAPIClient.genericErrorParse(),
                                body: body)
        OTMAPIClient.postRequest(resource: resource) { [unowned self](result) in
            switch result {
            case .success(let objectId):
                StudentAuthInfo.objectID = objectId
                self.updateStudentInfo(studentInfo, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func updateStudentInfo(_ studentInfo: StudentLocation, completion: @escaping (Result<Void, Error>) -> Void) {
        let parse: (Data) throws -> String = { data in
             let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            guard let updated =  dict?[DictionaryIds.updatedAt] as? String else {
                 throw DataError.noDataError
             }
             return updated
         }
         
         let body = {
             try JSONEncoder().encode(studentInfo)
         }
         
         let resource = Resource(url: OTMAPIClient.Endpoints.updateStudentLocation(objectId:  StudentAuthInfo.objectID).url,
                                 parse: parse,
                                 errorParse: OTMAPIClient.genericErrorParse(),
                                 body: body)
         
         OTMAPIClient.putRequest(resource: resource) { (result) in
             switch result {
             case .success(_):
                completion(.success(()))
             case .failure(let error):
                 completion(.failure(error))
             }
         }
    }
    
    
}
