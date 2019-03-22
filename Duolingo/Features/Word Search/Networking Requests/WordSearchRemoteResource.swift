//
//  WordSearchRemoteResource.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchRemoteResource: WordSearchResource {
    
    // MARK: - Private properties
    
    private static let amazonS3BaseUrl = "https://s3.amazonaws.com"
    private let networking: Networking
    private let jsonParser: JSONParsable
    
    // MARK: - Init
    
    init(networking: Networking = NetworkingManager(), jsonParser: JSONParsable = JSONParser()) {
        self.networking = networking
        self.jsonParser = jsonParser
    }
    
    // MARK: - Public methods
    
    func wordSearchChallenges(_ completion: @escaping ((Result<[WordSearchChallenge]>) -> Void)) {
        networking.request(
            baseUrl: WordSearchRemoteResource.amazonS3BaseUrl,
            endpoint: Endpoint(path: "/duolingo-data/s3/js2/find_challenges.txt",
                               method: .get)) { [weak self] result in
                                self?.parseCollection(result: result, completion: completion)
        }
    }
    
    // MARK: - Private methods
    
    private func parseCollection<T: Decodable>(result: Result<Data>, completion: ((Result<[T]>) -> Void)) {
        let result : Result<[T]> = self.jsonParser.parseCollection(fromResult: result)
        completion(result)
    }
}
