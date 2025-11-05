//
//  EnigmaTests.swift
//  EnigmaTests
//
//  Created by Damian Gwóźdź on 02/11/2025.
//

import XCTest
@testable import Enigma

final class CipheredTextTestSuite: XCTestCase {
    var sut = CipheredTextModel(openText: "", cipheredText: "", arrayOfCipheredText: [])

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testIsValidLetterPositiveCases() {
        let arrayOfPositiveCases = [ "A", "B", "C", "D", "e", "f", "z" ]

        for positiveCaseElement in arrayOfPositiveCases {
            XCTAssert(sut.isValidLetter(positiveCaseElement))
        }
    }

    func testIsValidLetterNegativeCases() {
        let arrayOfNegativeCases = [ " ", "\n", "123", "xyz", "" ]

        for negativeCaseElement in arrayOfNegativeCases {
            XCTAssertFalse(sut.isValidLetter(negativeCaseElement))
        }
    }

    func testGetLetterIndexReturnsRightIndexOrZero() {
        XCTAssert(sut.getLetterIndex("a") == 1)
        XCTAssert(sut.getLetterIndex("Z") == 26)
        XCTAssert(sut.getLetterIndex(" ") == 0)
    }

    func testAddOneLetterLowercaseToCipheredTextGetCipheredTextReturnsUppercasedCipheredText() {
        sut.addLetterToCipheredText("a")

        XCTAssert(sut.cipheredText.count == 1 && sut.cipheredText == "A")
        XCTAssertEqual(sut.getCipheredText(), "A")
    }

    func testAddOneLetterUppercaseToCipheredTextGetCipheredTextReturnsUnchangedLetterInCipheredText() {
        sut.addLetterToCipheredText("X")

        XCTAssert(sut.cipheredText.count == 1 && sut.cipheredText == "X")
        XCTAssertEqual(sut.getCipheredText(), "X")
    }

    func testAddSixLettersToCipheredTextGetArrayOfCpheredTextReturnsTwoStrings() {
        sut.addLetterToCipheredText("a")
        sut.addLetterToCipheredText("b")
        sut.addLetterToCipheredText("c")
        sut.addLetterToCipheredText("d")
        sut.addLetterToCipheredText("e")
        sut.addLetterToCipheredText("f")

        let expected = ["ABCDE", "F"]

        XCTAssertEqual(sut.getArrayOfSplittedCipheredText(), expected)
    }

    func testAddSevenLettersToCipheredTextGetArrayOfCpheredTextReturnsTwoStrings() {
        sut.addLetterToCipheredText("a")
        sut.addLetterToCipheredText("b")
        sut.addLetterToCipheredText("c")
        sut.addLetterToCipheredText("d")
        sut.addLetterToCipheredText("e")
        sut.addLetterToCipheredText("f")
        sut.addLetterToCipheredText("g")

        let expected = ["ABCDE", "FG"]

        XCTAssertEqual(sut.getArrayOfSplittedCipheredText(), expected)
    }

    func testAddTwoLettersToCipheredTextGetArrayOfCpheredTextReturnsOneString() {
        sut.addLetterToCipheredText("z")
        let expected = ["Z"]

        XCTAssertEqual(sut.getArrayOfSplittedCipheredText(), expected)
    }
}
