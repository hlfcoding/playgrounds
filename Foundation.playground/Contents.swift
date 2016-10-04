//:
//: ## Foundation Exploration
//:
import Foundation
//:
//: Check if string is numeric: http://stackoverflow.com/a/24633373/65465
//:
let digitCharSet = CharacterSet.decimalDigits
let textCharSet = CharacterSet(charactersIn: "123")
let isNumeric = digitCharSet.isSuperset(of: textCharSet)
//:
//: Convert string to number: http://stackoverflow.com/a/1448875/65465
//:
let numberStyle = NumberFormatter().numberStyle.rawValue
