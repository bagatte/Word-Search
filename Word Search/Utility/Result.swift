//
//  Result.swift
// WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(value : T)
    case error(Error)
}
