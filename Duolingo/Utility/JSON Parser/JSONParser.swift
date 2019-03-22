//
//  JSONParser.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class JSONParser: JSONParsable {
    
    // MARK: - Public methods
    
    func parseCollection<T: Decodable>(fromResult result: Result<Data>) -> Result<[T]> {
        switch result {
        case .success(let data):
            guard let string = String(data: data, encoding: .utf8) else {
                fatalError("\(type(of: self)) currently only supports parsing String data.")
            }
            
            do {
                let models: [T] = try parseCollection(from: string)
                return .success(value: models)
            } catch {
                return .error(error)
            }

        case .error(let error):
            return .error(error)
        }
    }
    
    // MARK: - Private methods
    
    private func parseCollection<T: Decodable>(from string: String) throws -> [T] {
        let lines = string.components(separatedBy: .newlines)
        
        return try lines.compactMap({ line -> T? in
            guard let data = line.data(using: .utf8), !line.isEmpty else {
                return nil
            }
            return try decode(data: data) as T
        })
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
