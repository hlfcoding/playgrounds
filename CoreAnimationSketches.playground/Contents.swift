//:
//: ## CoreAnimation Sketches
//:
//: Explore framework classes on a single stage.
//:
import XCPlayground
import UIKit

let gutter: CGFloat = 20.0
let stage = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 1100, height: 300)))
stage.backgroundColor = UIColor.lightGrayColor()
XCPlaygroundPage.currentPage.liveView = stage
//:
//: ### Simple Button
//:
//: A tour of base `CALayer` properties. Some layout boilerplate involved.
//:
let button = UIButton(frame: CGRect(origin: CGPoint(x: gutter, y: gutter), size: CGSizeZero))
button.setTitle("OK", forState: .Normal)
button.sizeToFit()
let padding: CGFloat = 10.0
button.frame.insetInPlace(dx: -padding, dy: 0.0)
button.frame.offsetInPlace(dx: padding, dy: 0.0)
stage.addSubview(button)

button.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
button.layer.backgroundColor = color(.White)
button.layer.borderColor = color(.Black, withAlpha: 0.4)
button.layer.borderWidth = 1.0
button.layer.cornerRadius = 5.0
button.layer.shadowColor = color(.Black)
button.layer.shadowOffset = CGSizeZero
button.layer.shadowOpacity = 0.3
button.layer.shadowRadius = 1.0
