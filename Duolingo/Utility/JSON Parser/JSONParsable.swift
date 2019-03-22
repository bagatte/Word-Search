//
//  JSONParsable.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol JSONParsable {
    
    func parseCollection<T: Decodable>(fromResult result: Result<Data>) -> Result<[T]>
}
