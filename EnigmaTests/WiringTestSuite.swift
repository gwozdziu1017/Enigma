//
//  WiringTestSuite.swift
//  EnigmaTests
//
//  Created by Damian Gwóźdź on 06/11/2025.
//

import XCTest
@testable import Enigma

final class WiringTestSuite: XCTestCase {
    let validWiringString = "EJMZALYXVBWFCRQUONTSPIKHGD"
    let wiringArray = CipheredTextModel.makeArrayFromString("EJMZALYXVBWFCRQUONTSPIKHGD")
    var wiringModelWithValidWiringArrayAndTurnoverNotchIsEqualToStartingIndex =
        WiringModel(
            wiringArray: CipheredTextModel.makeArrayFromString("EJMZALYXVBWFCRQUONTSPIKHGD"),
            startingIndex: "E",
            turnoverNotch: nil)

    var simpleWiringModel = WiringModel(wiringArray: "ABCD", startingIndex: "A", turnoverNotch: "C")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateWiringModelWhenWirringArrayIsOneString() {
        let sut = WiringModel(wiringArray: "STRING", startingIndex: "S", turnoverNotch: nil)
        XCTAssertEqual(sut!.wiringArray, ["S", "T", "R", "I", "N", "G"])
    }

    func testWiringModelCreateObjetWhenWiringArrayIsArrayOfStrings() {
        let sut = WiringModel(wiringArray: ["A", "B", "C"], startingIndex: "a", turnoverNotch: nil)
        XCTAssert(sut!.wiringArray == ["A", "B", "C"])
    }

    func testWiringModelCreateObjetWhenBothStartingIndexAndTurnoverNotchAreGivenAndAreValid() {
        let sut = WiringModel(wiringArray: "nvm", startingIndex: "N", turnoverNotch: "M")
        XCTAssertEqual(sut!.startingIndex, 0)
        XCTAssertEqual(sut!.turnoverNotch, 2)
    }

    func testWiringModelCreateObjetWhenOnlyStartingIndexIsGiven() {
        let sut = WiringModel(wiringArray: "NVM", startingIndex: "N", turnoverNotch: nil)
        XCTAssertEqual(sut!.startingIndex, 0)
        XCTAssertEqual(sut!.turnoverNotch, sut!.startingIndex)
    }

    func testWiringModelRotation() {
        XCTAssertEqual(simpleWiringModel!.wiringArray, ["A", "B", "C", "D"])
        simpleWiringModel!.rotate()
        XCTAssertEqual(simpleWiringModel!.wiringArray, ["B", "C", "D", "A"])
    }

    func testWiringModelRotationWhenTurnoverNotchIsReached() {
        XCTAssertEqual(simpleWiringModel!.wiringArray, ["A", "B", "C", "D"])
        simpleWiringModel!.rotate()
        simpleWiringModel!.rotate()
        simpleWiringModel!.rotate() // turnover notch reached
        XCTAssertEqual(simpleWiringModel!.wiringArray, ["D", "A", "B", "C"])
    }

    func testWiringModelRotateWhenStartingIndexIsSetAndPassedAsInt() {
        let sut = WiringModel(wiringArray: "ABCDEFGH", startingIndex: "C", turnoverNotch: nil)
        XCTAssertEqual(sut!.wiringArray, ["C", "D", "E", "F", "G", "H", "A", "B"])
    }

    func testWiringModelRotateWhenStartingndexIsSetAndPassedAsString() {
        let sut = WiringModel(wiringArray: "QWERTY", startingIndex: "E", turnoverNotch: nil)
        XCTAssertEqual(sut!.wiringArray, ["E", "R", "T", "Y", "Q", "W"])

    }

    func testWiringModelGetChangedLetter() {
        XCTAssertEqual(
            wiringModelWithValidWiringArrayAndTurnoverNotchIsEqualToStartingIndex?.getChangedLetter(),
            "E")
    }

    func testWiringModelGetChangedLetterTogetherWithRotation() {
        XCTAssertEqual(
            wiringModelWithValidWiringArrayAndTurnoverNotchIsEqualToStartingIndex?.getChangedLetter(),
            "E")
        wiringModelWithValidWiringArrayAndTurnoverNotchIsEqualToStartingIndex?.rotate()
        XCTAssertEqual(
            wiringModelWithValidWiringArrayAndTurnoverNotchIsEqualToStartingIndex?.getChangedLetter(),
            "J")
    }
}
