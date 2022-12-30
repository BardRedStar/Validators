//
//  Validator.swift
//
//  Created by Denis Kovalev
//

import Foundation

struct LengthValidator: Validator {
    private let minimumLength: Int
    private let errorText: String

    init(errorText: String, minimumLength: Int) {
        self.errorText = errorText
        self.minimumLength = minimumLength
    }

    init(errorText: String) {
        self.errorText = errorText
        minimumLength = 0
    }

    func validate(value: String) -> String? {
        value.trimmed().count > minimumLength ? nil : errorText
    }
}
