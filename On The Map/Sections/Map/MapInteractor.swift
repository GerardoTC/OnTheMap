//
//  MapInteractor.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation

class MapInteractor: MapInteractorProtocol {
    var currentTask: URLSessionTask?
    
    func getLocations(limit: Int, completion: @escaping (Result<[PinAnnotation], Error>) -> Void) {
        currentTask?.cancel()
        let studentInfoParse: (Data) throws -> StudentsInfo = { data in
            try JSONDecoder().decode(StudentsInfo.self, from: data)
        }
        
        let resource = Resource(url: OTMAPIClient.Endpoints.studentLocation(limit: limit).url,
                                parse: studentInfoParse,
                                errorParse: OTMAPIClient.genericErrorParse(),
                                body: nil)
        currentTask = OTMAPIClient.getRequest(resource: resource) { result in
                            switch result {
                            case .success(let students):
                                let pins: [PinAnnotation] = students.results.map { (student) -> PinAnnotation in
                                    PinAnnotation(coordinate: student.location,
                                                  title: "\(student.firstName) \(student.lastName)",
                                        subtitle: student.mediaURL)
                                }
                                completion(.success(pins))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
    }
}
