//:
//: # TIL: Swift
//: ---
//: ## Swift Cocoa Gotchas
//:
//: ### I. Foundation
//:
import Foundation
//:
//: Bridging is simply casting into NSArray.
//:
let list = [1, 2, 3]
let bridgedList = list as NSArray
bridgedList.index(of: 2)
//:
//: Swift Arrays are assigned by value, so use NSArray instead for assign by reference.
//:
var mutableList = list
var nastySurprise = mutableList
nastySurprise.append(4)
assert(mutableList.count == 3)

var mutableBridgedList = NSMutableArray(array: bridgedList)
var reliable = mutableBridgedList
reliable.add(4)
assert(mutableBridgedList.count == 4)
//:
//: ### II. CoreGraphics
//:
import CoreGraphics
//:
//: CGFloats must be explicitly typed, else they become Doubles.
//:
let num = 0.0
type(of: num)
let otherNum: CGFloat = 0.0
type(of: otherNum)

//:
//: ---
//: ## Swift 2
//:
//: ### I. Guards
//:
//: Guards test the true condition, unlike traditional 'if' guards.
//:
func doSomething(input: Any?) -> [String]? {
    guard let input = input as? String else { return nil }
    return [ input ]
}
assert(doSomething(input: nil) == nil)
assert(doSomething(input: "input")! == ["input"])
//:
//: ### II. Optional Pattern
//:
//: Useful for combining statements for more compact list comprehensions.
//:
for case let number? in ([1, 2, nil] as [Int?]) where number > 1 {
    assert(number == 2)
}
