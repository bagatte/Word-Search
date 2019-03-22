//
//  Networking.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol Networking {
    
    func request(baseUrl: String, endpoint: Endpoint, completion: @escaping ((Result<Data>) -> Void))
}
