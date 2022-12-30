//
//  String+Extensions.swift
//
//  Created by Denis Kovalev
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.'_%+-]+@[A-Za-z0-9.'-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: self)
    }

    func isValidPhone() -> Bool {
        let phoneRegex = "^\\([0-9]{3}\\)[0-9]{3}\\-[0-9]{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
}
