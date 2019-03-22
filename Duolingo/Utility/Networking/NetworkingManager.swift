//
//  NetworkingManager.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class NetworkingManager: Networking {

    // MARK: - Public methods
    
    func request(baseUrl: String,
                 endpoint: Endpoint,
                 completion: @escaping ((Result<Data>) -> Void)) {
        guard let url = URL(string: baseUrl + endpoint.path) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let sessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
        let sessionTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.error(NetworkingError.serverError(description: error.localizedDescription)))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.error(NetworkingError.unknown))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(value: data))
            }
        }
        sessionTask.resume()
    }
}
