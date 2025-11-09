//
//  CipheredTextModel.swift
//  Enigma
//
//  Created by Damian Gwóźdź on 02/11/2025.
//

/*
 CipheredTextModel is a struct responsible for all kind of text related operations
 */

import Foundation

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

struct CipheredTextModel {
    static func getLetterIndex(letter: String, arrayToGetIndexFrom: [String]) -> Int {
        let uppercasedArray = arrayToGetIndexFrom.map { $0.uppercased() }
        if letter.count == 1 && isValidLetter(letter) {
            return uppercasedArray.firstIndex(of: letter.uppercased())!
        }
        return 0
    }

    static func isValidLetter(_ letter: String) -> Bool {
        return letterToIndexArray.contains(letter.uppercased()) // all valid letters must be in letterToIndexArray
    }

    static func isStringArrayConsistingOfValidLetters(_ stringArray: [String]) -> Bool {
        guard !stringArray.isEmpty else {
            return false
        }

        for string in stringArray {
            if string.count != 1 || !isValidLetter(string) {
                return false
            }
        }
        return true
    }

    static func makeArrayFromString(_ string: String) -> [String] {
        var arrayToReturn: [String] = []
        for character in string {
            arrayToReturn.append(String(character))
        }
        return arrayToReturn
    }
}
