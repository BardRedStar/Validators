//
//  Validator.swift
//
//  Created by Denis Kovalev
//

import Foundation

struct EmptyValueValidator: Validator {
    private let errorText: String

    init(errorText: String) {
        self.errorText = errorText
    }

    func validate(value: String) -> String? {
        value.trimmed().isEmpty ? errorText : nil
    }
}
