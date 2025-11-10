//
//  PlugboardTestSuite.swift
//  EnigmaTests
//
//  Created by Damian Gwóźdź on 09/11/2025.
//

import XCTest
@testable import Enigma

final class PlugboardTestSuite: XCTestCase {
    var sut: PlugboardModel = PlugboardModel()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // isConnectionValid
    func testPlugboardModelWhenInvalidFirstLetterIsConnectionValidReturnsFalse() {
        XCTAssertFalse(sut.isConnectionValid(first: " ", second: "a"))
    }

    func testPlugboardModelWhenInvalidSecondLetterIsConnectionValidReturnsFalse() {
        XCTAssertFalse(sut.isConnectionValid(first: "a", second: "\t"))
    }
    func testPlugboardModelWhenSameLettersAreGivenIsConnectionValidReturnsFalse() {
        XCTAssertFalse(sut.isConnectionValid(first: "a", second: "a"))
    }

    func testPlugboardModelWhenIsFirstLetterAlreadyUsedIsConnectionValidReturnsFalse() {
        sut.appendLetterToUsedLetters(letter: "a")
        XCTAssertFalse(sut.isConnectionValid(first: "A", second: "b"))
    }

    func testPlugboardModelWhenIsSecondLetterAlreadyUsedIsConnectionValidReturnsFalse() {
        sut.appendLetterToUsedLetters(letter: "X")
        XCTAssertFalse(sut.isConnectionValid(first: "b", second: "X"))
    }

    func testPlugboardModelWhenIsConnectionAlreadyAddedIsConnectionValidReturnsFalse() {
        try! sut.addConnectionToPlugboard(firstLetter: "a", secondLetter: "b")
        XCTAssertFalse(sut.isConnectionValid(first: "a", second: "b"))
    }

    func testPlugboardModelWhenCounterIsMaxIsConnectionValidReturnsFalse() {
        try! sut.addConnectionToPlugboard(firstLetter: "a", secondLetter: "b")
        try! sut.addConnectionToPlugboard(firstLetter: "c", secondLetter: "d")
        try! sut.addConnectionToPlugboard(firstLetter: "e", secondLetter: "f")
        try! sut.addConnectionToPlugboard(firstLetter: "g", secondLetter: "h")
        try! sut.addConnectionToPlugboard(firstLetter: "i", secondLetter: "j")
        try! sut.addConnectionToPlugboard(firstLetter: "k", secondLetter: "l")
        try! sut.addConnectionToPlugboard(firstLetter: "m", secondLetter: "n")
        try! sut.addConnectionToPlugboard(firstLetter: "o", secondLetter: "p")
        try! sut.addConnectionToPlugboard(firstLetter: "q", secondLetter: "r")
        try! sut.addConnectionToPlugboard(firstLetter: "s", secondLetter: "t") // 10

        XCTAssertFalse(sut.isConnectionValid(first: "u", second: "v"))
    }

    // appendLetterToUsedLetters
    func testPlugboardModelAppendingLetterToUsedLetters() {
        XCTAssertEqual(sut.usedLetters, [])
        sut.appendLetterToUsedLetters(letter: "a")
        XCTAssertEqual(sut.usedLetters, ["A"])
    }

    // addConnectionToPlugboard
    func testPlugboardModelAddConnectionToPlugboardWhenConnectionIsValid() {
        try! sut.addConnectionToPlugboard(firstLetter: "A", secondLetter: "B")
        XCTAssertEqual(sut.connectedLettersArray.count, 1)
        XCTAssertEqual(sut.counter, 1)
        XCTAssertEqual(sut.connectedLettersArray.first, PlugboardConnection(first: "A", second: "B"))
        XCTAssert(try! sut.getLetter(input: "A") == "B")
    }

    func testPlugboardModelAddConnectionToPlugboardWhenConnectionIsNotValid() {
        XCTAssertThrowsError(try sut.addConnectionToPlugboard(firstLetter: "A", secondLetter: "A"))
    }

    // PlugboardConnection
    func testPlugboardConnectionWhenFirstGivenReturnSecond() {
        let plugboardConnection_AB: PlugboardConnection = PlugboardConnection(first: "A", second: "B")
        XCTAssertEqual(plugboardConnection_AB.first, "A")
        XCTAssertEqual(plugboardConnection_AB.second, "B")
        XCTAssertEqual(plugboardConnection_AB.getLetter("A"), "B")
        XCTAssertEqual(plugboardConnection_AB.getLetter("B"), "A")
    }

    func testPlugboardConnectionWhenSecondGivenReturnFirst() {
        let plugboardConnection_AB: PlugboardConnection = PlugboardConnection(first: "A", second: "B")
        XCTAssertEqual(plugboardConnection_AB.first, "A")
        XCTAssertEqual(plugboardConnection_AB.second, "B")
        XCTAssertEqual(plugboardConnection_AB.getLetter("B"), "A")
    }

    func testPlugboardConnectionComparingTwoSameObjectsReturnsTrue() {
        let firstPlugboardConnection: PlugboardConnection = PlugboardConnection(first: "A", second: "B")
        let secondPlugboardConnection: PlugboardConnection = PlugboardConnection(first: "A", second: "B")
        XCTAssertEqual(firstPlugboardConnection, secondPlugboardConnection)
    }

    func testPlugboardConnectionComparingTwoDifferentObjectsReturnsFalse() {
        let plugboardConnectionAB: PlugboardConnection = PlugboardConnection(first: "A", second: "B")
        let plugboardConnectionAC: PlugboardConnection = PlugboardConnection(first: "A", second: "C")
        let plugboardConnectionDB: PlugboardConnection = PlugboardConnection(first: "D", second: "B")
        let plugboardConnectionXY: PlugboardConnection = PlugboardConnection(first: "X", second: "Y")

        XCTAssertNotEqual(plugboardConnectionAB, plugboardConnectionAC) // first letter different
        XCTAssertNotEqual(plugboardConnectionAB, plugboardConnectionDB) // seond letter different
        XCTAssertNotEqual(plugboardConnectionAB, plugboardConnectionXY) // both differs
    }

    // removeConnection
    func testPlugboardModelRemoveConnectionWhenConnectionExists() {
        let plugboardConnection: PlugboardConnection = PlugboardConnection(first: "A", second: "O")
        sut.connectedLettersArray.append(plugboardConnection)
        sut.counter = 1

        try! sut.removeConnectionFromPlugboard(id: plugboardConnection.id)
        XCTAssertEqual(sut.connectedLettersArray.count, 0)
        XCTAssertEqual(sut.counter, 0)
    }

    func testPlugboardModelRemoveConnectionWhenConnectionDoesNotExists() throws {
        XCTAssertThrowsError(try sut.removeConnectionFromPlugboard(id: UUID()))
    }

    func testPlugboardModelRemoveAllConnectionsWhenAnyConnectionExists() {
        try! sut.addConnectionToPlugboard(firstLetter: "A", secondLetter: "O")
        try! sut.addConnectionToPlugboard(firstLetter: "Z", secondLetter: "U")
        XCTAssertEqual(sut.connectedLettersArray.count, 2)
        XCTAssertEqual(sut.counter, 2)

        try! sut.removeAllConnectionsFromPlugboard()
        XCTAssertEqual(sut.connectedLettersArray.count, 0)
        XCTAssertEqual(sut.counter, 0)
    }

    func testPlugboardModelRemoveAllConnectionsWhenNoConnectionExists() throws {
        XCTAssertThrowsError(try sut.removeConnectionFromPlugboard(id: UUID()))
    }
}
