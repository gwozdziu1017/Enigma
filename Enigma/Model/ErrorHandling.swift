//
//  ErrorHandling.swift
//  Enigma
//
//  Created by Damian Gwóźdź on 09/11/2025.
//

enum TextError: Error {
    case InvalidValue
}

enum PlugboardError: Error {
    case PlugboardConnectionError
    case RemovingConnectionError
}
