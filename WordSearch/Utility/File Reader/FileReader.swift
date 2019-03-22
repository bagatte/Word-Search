//
//  FileReader.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

final class FileReader: FileReadable {

    func contentsOfFile(_ filename: String, fileType: FileType) -> Result<Data> {
        guard let filePath = Bundle.main.path(forResource: filename, ofType: fileType.rawValue) else {
            return .error(FileReaderError.notFound)
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return .success(value: jsonData)
        } catch {
            return .error(error)
        }
    }
}
