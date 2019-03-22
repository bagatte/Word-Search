//
//  NetworkingError.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

enum NetworkingError: Error {

    case serverError(description: String?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .serverError(let description):
            if let description = description {
                return description
            } else {
                return "Server error."
            }
        case .unknown:
            return "Something went wrong."
        }
    }
}
