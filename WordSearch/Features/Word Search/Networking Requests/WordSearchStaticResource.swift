//
//  WordSearchStaticResource.swift
//  WordSearch
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import UIKit

class WordSearchStaticResource: WordSearchResource {
    
    // MARK: - Private properties
    
    private var fileReader: FileReadable
    private var jsonParser: JSONParsable
    
    // MARK: - Init
    
    init(jsonParser: JSONParsable = JSONParser(), fileReader: FileReadable = FileReader()) {
        self.jsonParser = jsonParser
        self.fileReader = fileReader
    }

    func wordSearchChallenges(_ completion: @escaping ((Result<[WordSearchChallenge]>) -> Void)) {
        let fileReaderResult = fileReader.contentsOfFile("json_structures", fileType: .text)
        let parseCollectionResult: Result<[WordSearchChallenge]> = jsonParser.parseCollection(fromResult: fileReaderResult)
        completion(parseCollectionResult)
    }
}
