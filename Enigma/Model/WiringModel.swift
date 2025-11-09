//
//  WiringModel.swift
//  Enigma
//
//  Created by Damian Gwóźdź on 06/11/2025.
//

struct WiringModel {
    var wiringArray: [String]
    let startingIndex: Int
    let turnoverNotch: Int
    var counter: Int = 0

    init?(
        wiringArray: [String],
        startingIndex: String,
        turnoverNotch: String?) {
            self.wiringArray = wiringArray
            self.startingIndex = CipheredTextModel.getLetterIndex(letter: startingIndex, arrayToGetIndexFrom: self.wiringArray)
            self.turnoverNotch = turnoverNotch != nil ? CipheredTextModel.getLetterIndex(letter: turnoverNotch!, arrayToGetIndexFrom: self.wiringArray) : self.startingIndex

            do {
                try setupWiringModel()
            }
            catch {
                return nil
            }
        }

    init?(
        wiringArray: String,
        startingIndex: String,
        turnoverNotch: String?) {
            self.wiringArray = CipheredTextModel.makeArrayFromString(wiringArray)
            self.startingIndex = CipheredTextModel.getLetterIndex(letter: startingIndex, arrayToGetIndexFrom: self.wiringArray)
            self.turnoverNotch = turnoverNotch != nil ? CipheredTextModel.getLetterIndex(letter: turnoverNotch!, arrayToGetIndexFrom: self.wiringArray) : self.startingIndex

            do {
                try setupWiringModel()
            }
            catch {
                return nil
            }
        }

    mutating func setupWiringModel() throws {
        try self.validateStartingIndexAndTurnoverNotch()
        try self.setupWiringArray()
    }

    mutating func setupWiringArray() throws {
        guard CipheredTextModel.isStringArrayConsistingOfValidLetters(self.wiringArray) else {
            throw TextError.invalidValue
        }
        if self.startingIndex > 0 {
            for _ in 0..<self.startingIndex {
                self.rotate()
            }
        }
    }

    func validateStartingIndexAndTurnoverNotch() throws {
        if !isIndexValid(index: self.startingIndex) || !isIndexValid(index: self.turnoverNotch) {
            throw TextError.invalidValue
        }
    }

    func isIndexValid(index: Int) -> Bool {
        return index >= 0 && index < self.wiringArray.count
    }

    mutating func rotate() {
        let firstElement = wiringArray.removeFirst()
        wiringArray.append(firstElement)
    }

    func getChangedLetter() -> String {
        return wiringArray.first!
    }

    func isTurnoverNotch(_ letter: String) -> Bool {
        return CipheredTextModel.getLetterIndex(letter: letter, arrayToGetIndexFrom: self.wiringArray) == turnoverNotch
    }

    func isFullCyclePassed() -> Bool {
        return counter > 26
    }

    mutating func incrementCounter() {
        self.counter += 1
    }

    mutating func resetCounter() {
        self.counter = 0
    }
}
