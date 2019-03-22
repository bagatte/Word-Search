//
//  WordSearchResource.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol WordSearchResource {
    
    func wordSearchChallenges(_ completion: @escaping ((Result<[WordSearchChallenge]>) -> Void))
}
