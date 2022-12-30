//
//  CharacterSet+Extensions.swift
//
//  Created by Denis Kovalev
//

import Foundation

extension CharacterSet {
    func contains(_ character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains)
    }
}

extension CharacterSet {
    static let specialSymbols = CharacterSet(charactersIn: #"!@#$%^&*()[]{}<>,.\|/?_+-=`~;:'""#)
}
