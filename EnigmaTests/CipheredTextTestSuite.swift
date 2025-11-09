//
//  EnigmaTests.swift
//  EnigmaTests
//
//  Created by Damian Gwóźdź on 02/11/2025.
//

import XCTest
@testable import Enigma

final class CipheredTextTestSuite: XCTestCase {

    let letterToIndexArray = [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
    ]

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testIsValidLetterPositiveCases() {
        let arrayOfPositiveCases = [ "A", "B", "C", "D", "e", "f", "z" ]

        for positiveCaseElement in arrayOfPositiveCases {
            XCTAssert(CipheredTextModel.isValidLetter(positiveCaseElement))
        }
    }

    func testIsValidLetterNegativeCases() {
        let arrayOfNegativeCases = [ " ", "\n", "123", "xyz", "" ]

        for negativeCaseElement in arrayOfNegativeCases {
            XCTAssertFalse(CipheredTextModel.isValidLetter(negativeCaseElement))
        }
    }

    func testGetLetterIndexReturnsRightIndexOrZero() {
        XCTAssert(CipheredTextModel.getLetterIndex(letter: "a", arrayToGetIndexFrom: letterToIndexArray) == 0)
        XCTAssert(CipheredTextModel.getLetterIndex(letter: "Z", arrayToGetIndexFrom: letterToIndexArray) == 25)
        XCTAssert(CipheredTextModel.getLetterIndex(letter: " ", arrayToGetIndexFrom: letterToIndexArray) == 0)
    }

    func testMakeArrayFromStringWhenValidStringReturnArrayOfStrings() {
        let validString = "ABCDEFG"
        XCTAssert(CipheredTextModel.makeArrayFromString(validString) == [ "A", "B", "C", "D", "E", "F", "G" ])
    }

    func testMakeArrayFromStringWhenValidStringEvenWithForbiddenCharactersReturnArrayOfStrings() {
        let validStringWithForbiddenChars = "ABCDEFG123"
        XCTAssert(CipheredTextModel.makeArrayFromString(validStringWithForbiddenChars) == [ "A", "B", "C", "D", "E", "F", "G", "1", "2", "3"])
    }

    func testMakeArrayFromStringWhenEmptyStringReturnEmptyArray() {
        let emptyString: String = ""
        XCTAssert(CipheredTextModel.makeArrayFromString(emptyString) == [])
    }

    func testIsStringArrayConsistingOfValidLettersWhenValidStringArrayReturnsTrue() {
        let validStringArray = ["A", "B", "c"]
        XCTAssert(CipheredTextModel.isStringArrayConsistingOfValidLetters(validStringArray))
    }

    func testIsStringArrayConsistingOfValidLettersWhenStringArrayContainsNumberReturnsFalse() {
        let invalidStringArray = ["A", "B", "1"]
        XCTAssertFalse(CipheredTextModel.isStringArrayConsistingOfValidLetters(invalidStringArray))
    }

    func testIsStringArrayConsistingOfValidLettersWhenStringArrayContainsSpecialCharacterReturnsFalse() {
        let invalidStringArray = ["A", "B", "\n"]
        XCTAssertFalse(CipheredTextModel.isStringArrayConsistingOfValidLetters(invalidStringArray))
    }

    func testIsStringArrayConsistingOfValidLettersWhenStringArrayContainsEmptyStringReturnsFalse() {
        let invalidStringArray = ["A", ""]
        XCTAssertFalse(CipheredTextModel.isStringArrayConsistingOfValidLetters(invalidStringArray))
    }

    func testIsStringArrayConsistingOfValidLettersWhenStringArrayContainsSpaceReturnsFalse() {
        let invalidStringArray = ["A", " "]
        XCTAssertFalse(CipheredTextModel.isStringArrayConsistingOfValidLetters(invalidStringArray))
    }

    func testIsStringArrayConsistingOfValidLettersWhenEmptyArrayReturnsFalse() {
        let invalidStringArray: [String] = []
        XCTAssertFalse(CipheredTextModel.isStringArrayConsistingOfValidLetters(invalidStringArray))
    }

}
