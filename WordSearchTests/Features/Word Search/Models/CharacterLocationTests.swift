//
//  CharacterLocationTests.swift
//  WordSearchTests
//
//  Created by bagatte on 3/9/19.
//  Copyright © 2019 brunoagatte. All rights reserved.
//

import XCTest

class CharacterLocationTests: XCTestCase {

    func testCharacterLocationInitializer() {
        let characterLocation = CharacterLocation(row: 1, column: 6)
        XCTAssertEqual(characterLocation.row, 1)
        XCTAssertEqual(characterLocation.column, 6)
    }

}
