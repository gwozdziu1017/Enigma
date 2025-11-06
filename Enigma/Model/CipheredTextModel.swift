//
//  CipheredTextModel.swift
//  Enigma
//
//  Created by Damian Gwóźdź on 02/11/2025.
//

/*
 CipheredTextModel is a struct responsible for all kind of text related operations such as:
    - calculating index of given letter
    - holding ciphered and open text
    etc
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
    static func getLetterIndex(_ letter: String) -> Int {
        if letter.count == 1 && isValidLetter(letter) {
            return letterToIndexArray.firstIndex(of: letter.uppercased())! + 1
        }
        return 0
    }
    
    static func isValidLetter(_ letter: String) -> Bool {
        return letterToIndexArray.contains(letter.uppercased()) // all valid letters must be in letterToIndexArray
    }
}
