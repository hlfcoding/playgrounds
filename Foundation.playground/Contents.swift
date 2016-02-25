//:
//: ## Foundation Exploration
//:
import Foundation
//:
//: Check if string is numeric: http://stackoverflow.com/a/24633373/65465
//:
let digitCharSet = NSCharacterSet.decimalDigitCharacterSet()
let textCharSet = NSCharacterSet(charactersInString: "123")
let isNumeric = digitCharSet.isSupersetOfSet(textCharSet)
//:
//: Convert string to number: http://stackoverflow.com/a/1448875/65465
//:
let numberStyle = NSNumberFormatter().numberStyle.rawValue
