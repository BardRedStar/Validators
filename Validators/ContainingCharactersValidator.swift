//
//  Validator.swift
//
//  Created by Denis Kovalev
//

import Foundation

struct ContainingCharactersValidator: Validator {
    private let errorText: String
    private let allowedCharacters: CharacterSet
    private let minimumAmount: Int

    init(errorText: String, allowedCharacters: CharacterSet, minimumAmount: Int) {
        self.errorText = errorText
        self.allowedCharacters = allowedCharacters
        self.minimumAmount = minimumAmount
    }

    init(errorText: String) {
        self.errorText = errorText
        minimumAmount = 0
        allowedCharacters = []
    }

    func validate(value: String) -> String? {
        let filteredValue = value.filter { allowedCharacters.contains($0) }
        return filteredValue.count >= minimumAmount ? nil : errorText
    }
}
