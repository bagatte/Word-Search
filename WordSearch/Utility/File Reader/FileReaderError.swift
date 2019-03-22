//
//  FileReaderError.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

enum FileReaderError: Error {
    case notFound
    
    var localizedDescription: String {
        switch self {
        case .notFound:
            return "No file found."
        }
    }
}
