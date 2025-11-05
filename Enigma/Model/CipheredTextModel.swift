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
    var openText: String
    var cipheredText: String
    var arrayOfCipheredText: [String]
    
    func getLetterIndex(_ letter: String) -> Int {
        if letter.count == 1 && isValidLetter(letter) {
            return letterToIndexArray.firstIndex(of: letter.uppercased())! + 1
        }
        return 0
    }
    
    func isValidLetter(_ letter: String) -> Bool {
        return letterToIndexArray.contains(letter.uppercased()) // all valid letters must be in letterToIndexArray
    }
    
    mutating func addLetterToCipheredText(_ letter: String) {
        cipheredText.append(letter.uppercased())
    }

    func getCipheredText() -> String {
        return String(cipheredText)
    }

    func splitStringIntoArrayOfFiveElementStrings(_ str: String) -> [String] {
        var counter = 0
        var tempString = ""
        var newArray: [String] = []
        
        for letter in str {
            tempString.append(letter)
            counter += 1
            if counter.isMultiple(of: 5) {
                newArray.append(tempString)
                tempString = ""
            }
        }
        newArray.append(tempString)
        return newArray
    }

    mutating func getArrayOfSplittedCipheredText() -> [String] {
        arrayOfCipheredText = splitStringIntoArrayOfFiveElementStrings(cipheredText)
        return arrayOfCipheredText
    }
}
