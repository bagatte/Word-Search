//
//  FileReadable.swift
//  Duolingo
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

protocol FileReadable {
    
    func contentsOfFile(_ filename: String, fileType: FileType) -> Result<Data>
}
