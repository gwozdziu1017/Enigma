//
//  PlugboardModel.swift
//  Enigma
//
//  Created by Damian Gwóźdź on 02/11/2025.
//
import Foundation

struct PlugboardConnection: Equatable {
    let id: UUID
    let first: String
    let second: String

    init(first: String, second: String) {
        self.id = UUID()
        self.first = first
        self.second = second
    }

    func getLetter(_ letter: String) -> String {
        if letter == self.first {
            return self.second
        } else {
            return self.first
        }
    }

    static func ==(lhs: PlugboardConnection, rhs: PlugboardConnection) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }
}

struct PlugboardModel {
    var connectedLettersArray: [PlugboardConnection] = []
    var counter: Int = 0
    let maxConnections: Int = 10
    var usedLetters: Set<String> = []

    func isConnectionValid(first: String, second: String) -> Bool {
        self.isLetterValid(first) &&
        self.isLetterValid(second) &&
        !self.isLetterAlreadyUsed(letter: first) &&
        !self.isLetterAlreadyUsed(letter: second) &&
        self.connectedLettersArray.count < self.maxConnections &&
        first != second
    }

    func isLetterValid(_ letter: String) -> Bool {
        letter.count == 1 && CipheredTextModel.isValidLetter(letter)
    }

    mutating func incrementCounter() {
        self.counter += 1
    }

    mutating func decrementCounter() {
        self.counter -= 1
    }

    mutating func resetCounter() {
        self.counter = 0
    }

     func isLetterAlreadyUsed(letter: String) -> Bool {
         self.usedLetters.contains(letter.uppercased())
    }

    mutating func appendLetterToUsedLetters(letter: String) {
        self.usedLetters.insert(letter.uppercased())
    }

    mutating func addConnectionToPlugboard(firstLetter: String, secondLetter: String) throws {
        guard self.isConnectionValid(first: firstLetter, second: secondLetter) else { throw PlugboardError.PlugboardConnectionError}

        self.appendLetterToUsedLetters(letter: firstLetter)
        self.appendLetterToUsedLetters(letter: secondLetter)

        self.connectedLettersArray.append(PlugboardConnection(first: firstLetter, second: secondLetter))
        self.incrementCounter()
    }

    mutating func removeConnectionFromPlugboard(id: UUID) throws {
        if let indexToRemove = self.connectedLettersArray.firstIndex(where: {$0.id == id}) {
            self.connectedLettersArray.remove(at: indexToRemove)
            self.decrementCounter()
        }
        else {
            throw PlugboardError.RemovingConnectionError
        }
    }

    mutating func removeAllConnectionsFromPlugboard() throws {
        connectedLettersArray.removeAll()
        self.resetCounter()
    }

    func getLetter(input: String) throws -> String {
        guard self.isLetterValid(input) else { throw PlugboardError.PlugboardConnectionError }
        var output: String
        if usedLetters.contains(input.uppercased()) {
            output = connectedLettersArray.getLetter(input.uppercased())
        }
        else {
            output = input
        }
        return output
    }
}

extension Array where Element == PlugboardConnection {

    func getLetter(_ input: String) -> String {
        if let output = self.first(where: { $0.first == input }) {
            return output.second
        }
        else {
            let output = self.first(where: {$0.second == input})
            return output!.first
        }
    }
}
