//
//  Validator.swift
//
//  Created by Denis Kovalev
//

import Foundation

protocol Validator {
    init(errorText: String)

    func validate(value: String) -> String?
}
