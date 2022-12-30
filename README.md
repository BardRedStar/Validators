# Validators

A pool of validators for string data

## 💿 Installation 

Add `Validators` and `Extensions` directories from this repository to your project and that's it!

## 📦 What is included

* `Validator` - a generic protocol for validators (see *How to add custom validator*).
* `ContainingCharactersValidator` - a validator that checks string for minimum amount (`minimumAmount`) of characters of special group (`allowedCharacters`).
* `EmailValidator` - a validator that checks whether the string has valid email format or not.
* `EmptyValueValidator` - a validator that checks string for emptiness
* `EqualValueValidator` - a validator that checks that string is equal to another string
* `NotEqualValueValidator` - a validator that checks that string is NOT equal to another string
* `LengthValidator` - a validator that checks that string length is greater than `minimumLength`

## 🔨 How to add a custom validator

To add a custom validator, simply implement the `Validator` protocol into your class/struct. 

`errorString` parameter in initalizer should be used as text for error messaage, if validation fails.

`validate(_:)` method should return `nil` if value passes the validation, and `errorString` otherwise. 

Example:
```swift
struct EmptyValueValidator: Validator {
    private let errorText: String

    init(errorText: String) {
        self.errorText = errorText
    }

    func validate(value: String) -> String? {
        value.trimmed().isEmpty ? errorText : nil
    }
}
```

## 🪄 How to use 

Imagine we have a form with two fields - email and password. 
Email should:
- not be empty;
- match email address pattern.

Password should:
- not be less than 8 letters length,
- contain 1 uppercase letter,
- contain 1 lowercase letter,
- contain 1 digit,
- contain 1 special symbol.

The goal is to validate email and password values according to the rules above.

One of the solutions is to create an enum for fields and assign validators that belong to corresponding field:

```swift
enum Field {
    case email, password

    var validators: [Validator] {
        switch self {
        case .email:
            return [
                EmptyValueValidator(errorText: "Email is empty"),
                EmailValidator(errorText: "Email has incorrect format")
            ]
        case .password:
            return [
                LengthValidator(
                    errorText: "Password is less that 8 letters length",
                    minimumLength: 8
                ),
                ContainingCharactersValidator(
                    errorText: "Password should contain at least 1 uppercase letter",
                    allowedCharacters: .uppercaseLetters,
                    minimumAmount: 1
                ),
                ContainingCharactersValidator(
                    errorText: "Password should contain at least 1 lowercase letter",
                    allowedCharacters: .lowercaseLetters,
                    minimumAmount: 1
                ),
                ContainingCharactersValidator(
                    errorText: "Password should contain at least 1 digit",
                    allowedCharacters: .decimalDigits,
                    minimumAmount: 1
                ),
                ContainingCharactersValidator(
                    errorText: "Password should contain at least 1 special symbol",
                    allowedCharacters: .specialSymbols,
                    minimumAmount: 1
                )
            ]
        }
    }
}
```

Then create a method that takes a dictionary `[Field: String]` 
and returns the only fields that have errors - `[Field: [String]]`:

```swift
func validate(values: [Field: String]) -> [Field: [String]] {
    values.reduce(into: [Field: [String]]()) { result, element in
        let errors = element.key.validators.compactMap { $0.validate(value: element.value) }
        result[element.key] = errors.isEmpty ? nil : errors
    }
}
```

Well, we have validated fields with errors in dictionary. Apply them into fields and that's it!